-- tool: claude-code
-- model: claude-opus-5-5
-- date: 2026-09-28
-- status: applied
-- related: [nvim/.config/nvim/lua/plugins/herdr-splits.lua]
--
-- DROP-IN REPLACEMENT for nvim/.config/nvim/lua/plugins/herdr-splits.lua. Delete this
-- header block when applying. Changes vs current:
--   1. ensure_herdr_plugins(): on startup inside herdr, runs `herdr plugin list --json`
--      asynchronously and installs (or, with herdr_bootstrap = "notify", just flags) any
--      herdr plugin in the herdr_plugins list that's missing. herdr-splits is pinned to the
--      commit lazy has checked out.
--   2. auto_sync_herdr = true + build hook: keeps an EXISTING herdr-side install on the lazy
--      commit after :Lazy update (upstream feature; it no-ops when the plugin is missing,
--      which is why (1) is needed for a fresh box).
--
-- Where the list lives: ap_linux_setup's inventory `herdr_plugins` is the main installer
-- (proposal 13_herdr_plugins). Keep this list to herdr plugins that nvim itself depends on
-- (today, just herdr-splits). herdr plugins unrelated to nvim shouldn't depend on nvim
-- being launched.
--
-- Cost: with everything installed, startup spawns `herdr plugin list` once, async (off the
-- critical path), plus upstream's own synchronous list call from auto_sync_herdr.
--
-- Verified: luac -p clean. Headless nvim against an isolated empty HOME with no herdr server
-- (herdr-splits/lazy stubbed): run 1 installed herdr-splits @ 94f30cf (= lazy-lock),
-- run 2 did nothing.

-- herdr plugins this nvim config depends on. On startup inside herdr, any that `herdr plugin
-- list` doesn't report get installed (or just flagged, per herdr_bootstrap). The ansible
-- playbook (ap_linux_setup herdr_plugins) is the primary installer; this catches a box
-- where that step didn't run. herdr-splits upstream can't cover this itself:
-- auto_sync_herdr only re-pins an existing install and no-ops when it's missing.
--   `lazy`: lazy.nvim plugin name; a first install is pinned to the commit lazy checked out,
--           so the herdr-side bash scripts match the lua side. `ref` pins explicitly instead.
local herdr_plugins = {
  { id = "herdr-splits", source = "lmilojevicc/herdr-splits.nvim", lazy = "herdr-splits.nvim" },
}
local herdr_bootstrap = "install" -- "install" | "notify" | "off"

local function notify(msg, level)
  vim.schedule(function()
    vim.notify(msg, level or vim.log.levels.INFO, { title = "herdr plugins" })
  end)
end

-- Runs from vim.schedule, so the blocking git call is fine (and only on the missing path).
local function lazy_commit(name)
  local plugin = name and require("lazy.core.config").plugins[name]
  if not plugin or not plugin.dir then
    return nil
  end
  local res = vim.system({ "git", "-C", plugin.dir, "rev-parse", "HEAD" }, { text = true }):wait()
  return res.code == 0 and vim.trim(res.stdout) or nil
end

local function install(bin, want)
  vim.schedule(function()
    local cmd = { bin, "plugin", "install", want.source, "--yes" }
    local ref = want.ref or lazy_commit(want.lazy)
    if ref then
      vim.list_extend(cmd, { "--ref", ref })
    end
    vim.system(cmd, { text = true }, function(res)
      if res.code == 0 then
        notify(("installed %s%s; prefix+shift+r if its keys don't work yet"):format(
          want.id, ref and (" @ " .. ref:sub(1, 7)) or ""))
      else
        notify(("failed to install %s: %s"):format(want.id, vim.trim(res.stderr or "")), vim.log.levels.WARN)
      end
    end)
  end)
end

-- Async: `herdr plugin list` must never hold up startup.
local function ensure_herdr_plugins()
  local bin = vim.env.HERDR_BIN_PATH or "herdr"
  if herdr_bootstrap == "off" or vim.fn.executable(bin) ~= 1 then
    return
  end
  vim.system({ bin, "plugin", "list", "--json" }, { text = true }, function(res)
    local ok, data = pcall(vim.json.decode, res.code == 0 and res.stdout or "")
    local plugins = ok and type(data) == "table" and type(data.result) == "table" and data.result.plugins
    if type(plugins) ~= "table" then
      return
    end
    local installed = {}
    for _, p in ipairs(plugins) do
      installed[p.plugin_id] = true
    end
    for _, want in ipairs(herdr_plugins) do
      if not installed[want.id] then
        if herdr_bootstrap == "install" then
          install(bin, want)
        else
          notify(("herdr plugin %s is missing: herdr plugin install %s"):format(want.id, want.source),
            vim.log.levels.WARN)
        end
      end
    end
  end)
end

return {
  "lmilojevicc/herdr-splits.nvim",
  cond = function()
    return vim.env.HERDR_ENV == "1"
  end,
  event = "VeryLazy",
  -- Re-pin the herdr-side checkout whenever lazy updates the lua side (needs auto_sync_herdr).
  build = ':lua require("herdr-splits").sync_herdr()',
  config = function()
    require("herdr-splits").setup({
      -- Mirrors nvim/.config/nvim/lua/plugins/smart-splits.lua so muscle memory
      -- carries over: same keys, same resize step, same wrap-at-edge default.
      neovim_amount = 3,
      at_edge = "wrap",
      nav_at_edge = "wrap",
      move_cursor_same_row = false,
      nav_keys = { left = "<C-h>", down = "<C-j>", up = "<C-k>", right = "<C-l>" },
      resize_keys = { left = "<A-h>", down = "<A-j>", up = "<A-k>", right = "<A-l>" },
      -- Keep the herdr-side scripts on the same commit as lazy-lock. Existing installs only.
      auto_sync_herdr = true,
    })
    ensure_herdr_plugins()
  end,
  keys = {
    { "<C-h>", function() require("herdr-splits").move_cursor_left() end, desc = "move cursor left (herdr-aware)" },
    { "<C-j>", function() require("herdr-splits").move_cursor_down() end, desc = "move cursor down (herdr-aware)" },
    { "<C-k>", function() require("herdr-splits").move_cursor_up() end, desc = "move cursor up (herdr-aware)" },
    { "<C-l>", function() require("herdr-splits").move_cursor_right() end, desc = "move cursor right (herdr-aware)" },
    { "<A-h>", function() require("herdr-splits").resize_left() end, desc = "resize left (herdr-aware)" },
    { "<A-j>", function() require("herdr-splits").resize_down() end, desc = "resize down (herdr-aware)" },
    { "<A-k>", function() require("herdr-splits").resize_up() end, desc = "resize up (herdr-aware)" },
    { "<A-l>", function() require("herdr-splits").resize_right() end, desc = "resize right (herdr-aware)" },
  },
}
