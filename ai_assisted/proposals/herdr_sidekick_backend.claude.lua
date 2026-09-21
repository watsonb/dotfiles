--[[
tool: claude-code
model: claude-sonnet-5
date: 2026-09-14
status: proposed
related: [nvim/.config/nvim/lua/plugins/sidekick.lua]
--]]

-- OPTION B: deep integration — register a custom "herdr" multiplexer backend with
-- sidekick.nvim's own session-backend system, so <leader>aa keeps going through
-- sidekick (context-sending, picker UI, etc.) but the CLI actually lands in a real
-- herdr pane instead of an nvim-embedded terminal.
--
-- WHY THIS IS POSSIBLE
-- sidekick.cli.session (see .local/share/nvim/lazy/sidekick.nvim/lua/sidekick/cli/
-- session/init.lua) only hardcodes "tmux" and "zellij" as built-in backends, but
-- `M.register(name, backend)` is a public function and `M.backends` is just a plain
-- table keyed by name -- nothing stops adding a third one from user config. Compare
-- this file against sidekick/cli/session/tmux.lua, which this is modeled on 1:1
-- (same method contract: init/start/attach/is_running/sessions/send/submit/dump).
--
-- WHY THIS IS NEEDED (see herdr_sidekick_keymap.claude.lua for the fuller writeup)
-- herdr's automatic agent detection doesn't see into nested PTYs (confirmed against
-- herdr's docs and live: this session's own pane shows agent_status":"unknown" while
-- running nested inside nvim). The fix is the same either way: give Claude Code its
-- own herdr pane as a direct foreground process. This file does that *through*
-- sidekick's session abstraction instead of around it.
--
-- TRADE-OFF vs. OPTION A
-- Preserves sidekick's context-sending and multi-session picker for herdr-backed
-- sessions. Cost: sidekick.cli.session's method contract (B:init/start/attach/...)
-- is internal, undocumented, and unversioned -- a sidekick update could silently
-- change or drop it, and this file would need to be revisited.
--
-- STATUS / OPEN QUESTIONS FOR REVIEW
-- - `sessions()` below assumes `herdr agent list` returns objects shaped roughly
--   like `{ name, pane_id, kind, state }` (matching the flags documented for
--   `herdr pane report-agent`: --agent LABEL --state ...). This was NOT confirmed
--   against a live populated agent list (this machine currently has zero tracked
--   agents) -- inspect real output with an agent running before trusting the
--   field names used in `sessions()`.
-- - No "window vs split" distinction like tmux.lua has; herdr's `pane split` only
--   has --direction right|down. Adjust `Config.cli.mux.split.vertical` mapping if
--   your sidekick config uses that option differently than tmux's split.vertical.
-- - `is_running()` shells out to `herdr pane get` every poll; fine for occasional
--   checks, but if sidekick polls this in a tight loop, prefer caching against
--   `herdr agent list` instead.
--
-- WIRING (in sidekick.lua's lazy spec, inside `config = function(_, opts)`, run
-- BEFORE opts is applied, or in an early `init`):
--
--   require("sidekick.cli.session").register("herdr", require("path.to.this.file"))
--
-- ...then set in sidekick's opts:
--
--   cli = { mux = { enabled = true, backend = "herdr" } }

local Util = require("sidekick.util")

---@class sidekick.cli.muxer.Herdr: sidekick.cli.Session
---@field herdr_pane_id string
local M = {}
M.__index = M

--- kind values herdr's `agent start --kind` accepts; sidekick tool names mostly line up.
local KIND_ALIASES = {
  claude = "claude",
  codex = "codex",
  gemini = "gemini",
  copilot = "copilot",
}

local function herdr(args)
  local cmd = { "herdr" }
  vim.list_extend(cmd, args)
  local out = Util.exec(cmd, { notify = true })
  if not out then
    return nil
  end
  local ok, decoded = pcall(vim.json.decode, table.concat(out, "\n"))
  return ok and decoded or nil
end

function M:init()
  self.mux_session = self.mux_session or self.sid
end

---@return sidekick.cli.terminal.Cmd?
function M:start()
  local kind = KIND_ALIASES[self.tool.name]
  if not kind then
    Util.warn(("herdr backend: no --kind mapping for tool %q"):format(self.tool.name))
    return
  end

  local Config = require("sidekick.config")
  local direction = Config.cli.mux.split.vertical and "right" or "down"

  local split = herdr({
    "pane", "split",
    "--current",
    "--direction", direction,
    "--cwd", self.cwd,
  })
  local pane_id = split and split.result and split.result.pane and split.result.pane.pane_id
  if not pane_id then
    Util.error("herdr backend: `herdr pane split` did not return a pane_id")
    return
  end

  local name = (kind .. "-" .. pane_id):gsub("[^%w%-]", "-"):sub(1, 32)
  local args = self.tool.args or {}
  local start_cmd = { "agent", "start", name, "--kind", kind, "--pane", pane_id }
  if #args > 0 then
    vim.list_extend(start_cmd, { "--" })
    vim.list_extend(start_cmd, args)
  end

  local started = herdr(start_cmd)
  if not started then
    Util.error("herdr backend: `herdr agent start` failed for pane " .. pane_id)
    return
  end

  self.herdr_pane_id = pane_id
  self.id = "herdr " .. pane_id
  self.started = true
  Util.info(("Started **%s** in a new herdr pane (%s)"):format(self.tool.name, pane_id))
end

---@return sidekick.cli.terminal.Cmd?
function M:attach()
  -- Nothing to spawn locally: focus the existing herdr pane instead of opening a
  -- terminal buffer inside Neovim (that would recreate the original nesting problem).
  if self.herdr_pane_id then
    herdr({ "pane", "focus", self.herdr_pane_id })
  end
end

function M:is_running()
  if not self.herdr_pane_id then
    return false
  end
  local got = herdr({ "pane", "get", self.herdr_pane_id })
  return got ~= nil
end

--- CONFIRM against live `herdr agent list` output before relying on this.
function M.sessions()
  local Config = require("sidekick.config")
  local tools = Config.tools()
  local agents = herdr({ "agent", "list" })
  local ret = {} ---@type sidekick.cli.session.State[]
  for _, a in ipairs(agents and agents.result and agents.result.agents or {}) do
    for _, tool in pairs(tools) do
      if KIND_ALIASES[tool.name] == a.kind then
        ret[#ret + 1] = {
          id = "herdr " .. a.pane_id,
          cwd = a.cwd or vim.fn.getcwd(0),
          tool = tool,
          herdr_pane_id = a.pane_id,
          mux_session = a.pane_id,
        }
        break
      end
    end
  end
  return ret
end

function M:send(text)
  herdr({ "pane", "send-text", self.herdr_pane_id, text })
end

function M:submit()
  herdr({ "pane", "send-keys", self.herdr_pane_id, "enter" })
end

function M:dump()
  local Config = require("sidekick.config")
  local out = Util.exec({
    "herdr", "pane", "read", self.herdr_pane_id,
    "--lines", tostring(Config.cli.mux.dump),
    "--format", "text",
  }, { notify = false })
  return out and table.concat(out, "\n")
end

return M
