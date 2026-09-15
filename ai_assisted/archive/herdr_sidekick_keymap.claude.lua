--[[
tool: claude-code
model: claude-sonnet-5
date: 2026-09-14
status: applied
related: [nvim/.config/nvim/lua/config/keymaps.lua]
--]]

-- OPTION A: shallow integration — a keymap that bypasses sidekick's own CLI-session
-- machinery entirely and drives herdr's pane/agent CLI directly.
--
-- WHY THIS EXISTS
-- herdr's own docs state agent detection "does not inspect tmux sessions launched
-- inside a Herdr pane" -- the same applies to Neovim's embedded :terminal, which is
-- what sidekick currently uses (its `cli.mux` is commented out in sidekick.lua).
-- Confirmed live: `herdr pane list` shows this session's own pane (the one running
-- nvim+sidekick+claude) with agent_status":"unknown"`, and `herdr agent list` returns
-- no agents at all. For herdr to track the agent, Claude Code must be the *direct*
-- foreground process of its own herdr pane -- a sibling pane, not nested in nvim's PTY.
--
-- WHAT THIS DOES
-- <leader>aa splits a real herdr pane next to the current one and starts Claude Code
-- in it via `herdr agent start`, which is herdr's supported way to attach a supported
-- CLI agent to an existing shell pane and have it tracked in the agents sidebar.
--
-- TRADE-OFF vs. OPTION B (herdr_sidekick_backend.claude.lua)
-- Simple, has no dependency on sidekick's internal Lua API, and is easy to reason
-- about/debug on its own. But it does NOT go through sidekick's session-backend
-- object, so sidekick features that rely on that (sending the current buffer/
-- selection/diagnostics as context into the running CLI session, tracking multiple
-- concurrent tool sessions per project, the picker UI) will not see or control the
-- pane this creates -- from sidekick's point of view it's just an agent that showed
-- up in herdr, unrelated to sidekick.cli.
--
-- UNTESTED: the JSON field path (`result.pane.pane_id`) matches herdr's documented
-- CLI reference and the shape observed live from `herdr pane list`, but `herdr pane
-- split` itself was not executed during research (it would have opened a visible
-- pane in the live session). Worth a manual try before trusting it blindly.
--
-- Drop into e.g. nvim/.config/nvim/lua/config/keymaps.lua, or fold into
-- nvim/.config/nvim/lua/plugins/sidekick.lua as a `keys` entry with `mode = "n"`.
--
-- Bound to <leader>ah (not <leader>aa) for now, so it can be trialled side-by-side
-- with sidekick's existing <leader>aa without touching that mapping.

---@param kind string herdr's --kind value: pi, claude, codex, gemini, cursor, devin,
---  agy, cline, omp, mastracode, opencode, copilot, kimi, kiro, droid, amp, grok,
---  hermes, kilo, qodercli, qwen, maki, muse
local function herdr_launch_agent(kind)
  kind = kind or "claude"

  local split_out = vim.fn.system({
    "herdr", "pane", "split",
    "--current",
    "--direction", "right",
    "--cwd", vim.fn.getcwd(0),
  })
  if vim.v.shell_error ~= 0 then
    vim.notify("herdr pane split failed: " .. split_out, vim.log.levels.ERROR)
    return
  end

  local ok, decoded = pcall(vim.json.decode, split_out)
  local pane_id = ok and decoded.result and decoded.result.pane and decoded.result.pane.pane_id
  if not pane_id then
    vim.notify("herdr pane split: unexpected output: " .. split_out, vim.log.levels.ERROR)
    return
  end

  -- herdr agent start needs a name matching [a-z][a-z0-9_-]{0,31}
  local name = (kind .. "-" .. pane_id):gsub("[^%w%-]", "-"):sub(1, 32)

  local start_out = vim.fn.system({
    "herdr", "agent", "start", name,
    "--kind", kind,
    "--pane", pane_id,
  })
  if vim.v.shell_error ~= 0 then
    vim.notify("herdr agent start failed: " .. start_out, vim.log.levels.ERROR)
  end
end

vim.keymap.set("n", "<leader>ah", function()
  herdr_launch_agent("claude")
end, { desc = "Launch Claude Code in a new herdr-tracked pane" })
