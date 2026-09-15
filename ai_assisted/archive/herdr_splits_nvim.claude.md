---
tool: claude-code
model: claude-sonnet-5
date: 2026-09-15
status: applied
related: [nvim/.config/nvim/lua/plugins/smart-splits.lua, nvim/.config/nvim/lua/config/keymaps.lua, herdr/.config/herdr/config.toml, ai_assisted/research/herdr_nvim_survey.claude.md]
---

# Add lmilojevicc/herdr-splits.nvim for seamless herdr-pane <-> nvim-split navigation

Implements the top recommendation from `ai_assisted/research/herdr_nvim_survey.claude.md`:
`<C-h/j/k/l>` and `<A-h/j/k/l>` should move/resize across nvim splits AND cross into
neighboring herdr panes at an edge — the same way they'd cross into tmux panes if we
were using smart-splits' tmux integration. Right now, inside a herdr pane, those keys
only move within nvim; hitting an edge just does nothing (no multiplexer_integration is
configured, since herdr isn't tmux/wezterm/kitty).

Three pieces, following the plugin's own documented install (verified against the
live README, and against this machine's herdr v0.9.0 which does have `herdr plugin
install|link|action`):

1. herdr-side plugin install (one shell command, not a tracked file)
2. new nvim plugin spec (new file)
3. two small edits so the existing smart-splits.nvim setup doesn't fight with it
   inside a herdr pane (the plugin author's own README explicitly recommends this)
4. herdr keybind wiring in `herdr/.config/herdr/config.toml` (already a tracked,
   stow-managed file in this repo)

## 1. Install the herdr-side plugin (one-time, per machine)

Not a file edit — run this yourself when ready:

```bash
herdr plugin install lmilojevicc/herdr-splits.nvim
```

This is what provides the `herdr-splits.nav-*` / `herdr-splits.resize-*` actions the
config.toml bindings below invoke. `herdr plugin list` should then show it installed
(today it reports "No plugins installed").

## 2. New file: `nvim/.config/nvim/lua/plugins/herdr-splits.lua`

```lua
return {
  "lmilojevicc/herdr-splits.nvim",
  cond = function()
    return vim.env.HERDR_ENV == "1"
  end,
  event = "VeryLazy",
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
    })
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
```

Notes:
- `cond` means this plugin (and its `keys`) is entirely skipped by lazy.nvim outside a
  herdr pane — no behavior change for plain-terminal or tmux nvim sessions.
- Used `<A-h/j/k/l>` (not the README's `<M-h/j/k/l>`) to match the exact lhs already
  bound in `keymaps.lua` today — `<A->` and `<M->` are the same modifier in Neovim's
  key notation, this is purely a spelling choice to match existing config.
- Left `ignored_filetypes`/`ignored_buftypes` at the plugin's defaults — they already
  cover Trouble/NvimTree, which is what `nvim/.config/nvim/lua/plugins/smart-splits.lua`
  also special-cases today.

## 3. Edit `nvim/.config/nvim/lua/plugins/smart-splits.lua`

Add a `cond` so smart-splits.nvim doesn't load inside a herdr pane — this is the
plugin author's own documented compatibility note ("If you're using smart-splits.nvim
for tmux, add `cond = vim.env.HERDR_ENV ~= '1'` to its spec so the two plugins don't
conflict"):

```diff
 return {
   "mrjones2014/smart-splits.nvim",
+  cond = function()
+    return vim.env.HERDR_ENV ~= "1"
+  end,
   config = function()
     require("smart-splits").setup({
```

## 4. Edit `nvim/.config/nvim/lua/config/keymaps.lua`

The existing smart-splits keymap block (lines ~99-117) calls `require("smart-splits")`
directly and eagerly (not through lazy's `keys` table), so it must be skipped when the
plugin is `cond`-disabled — otherwise it errors on `require` inside every herdr pane.
Wrap it in a guard, and note the one feature gap: herdr-splits.nvim has no buffer-swap
equivalent, so `<leader><leader>h/j/k/l>` simply won't exist inside a herdr pane.

```diff
+-- smart-splits owns these outside herdr (plain terminal, tmux, wezterm, kitty).
+-- Inside a herdr pane, nvim/.config/nvim/lua/plugins/herdr-splits.lua's own `keys`
+-- table takes over <C-h/j/k/l> and <A-h/j/k/l> instead (see that file's cond).
+-- Known gap: herdr-splits.nvim has no swap_buf_* equivalent, so the
+-- <leader><leader>h/j/k/l> mappings below are simply unavailable in a herdr pane.
+if vim.env.HERDR_ENV ~= "1" then
   -- smart splits
   -- recommended mappings
   -- resizing splits
   -- these keymaps will also accept a range,
   -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
   vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left, { desc = "resize left" })
   vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down, { desc = "resize down" })
   vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up, { desc = "resize up" })
   vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right, { desc = "resize right" })
   -- moving between splits
   vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "move cursor left" })
   vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "move cursor down" })
   vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "move cursor up" })
   vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "move cursor right" })
   -- swapping buffers between windows
   vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left, { desc = "swap buffer left" })
   vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down, { desc = "swap buffer down" })
   vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up, { desc = "swap buffer up" })
   vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right, { desc = "swap buffer right" })
+end
```

## 5. Edit `herdr/.config/herdr/config.toml`

Append to the end of the `[keys]` section (after the commented-out defaults, alongside
where the doc comments already show `[[keys.command]]` examples). These are currently
unbound in this config, so no existing bindings are displaced:

```diff
 # Custom commands use the same binding syntax.
 # type = "shell" runs detached in the background.
 # type = "pane" opens a temporary pane and closes it when the command exits.
 # type = "popup" opens a session-modal terminal without changing the tab layout.
 # Popup width and height accept terminal cells or percentages such as "80%".
 # On Windows, command strings run through cmd.exe /d /c.
 # [[keys.command]]
 # key = "prefix+alt+g"
 # type = "popup"
 # command = "lazygit"
 # width = "80%"
 # height = "80%"
+
+# herdr-splits.nvim: seamless nav/resize across herdr panes and nvim splits.
+# See ai_assisted/proposals/herdr_splits_nvim.claude.md.
+[[keys.command]]
+key = "ctrl+h"
+type = "plugin_action"
+command = "herdr-splits.nav-left"
+
+[[keys.command]]
+key = "ctrl+j"
+type = "plugin_action"
+command = "herdr-splits.nav-down"
+
+[[keys.command]]
+key = "ctrl+k"
+type = "plugin_action"
+command = "herdr-splits.nav-up"
+
+[[keys.command]]
+key = "ctrl+l"
+type = "plugin_action"
+command = "herdr-splits.nav-right"
+
+[[keys.command]]
+key = "alt+h"
+type = "plugin_action"
+command = "herdr-splits.resize-left"
+
+[[keys.command]]
+key = "alt+j"
+type = "plugin_action"
+command = "herdr-splits.resize-down"
+
+[[keys.command]]
+key = "alt+k"
+type = "plugin_action"
+command = "herdr-splits.resize-up"
+
+[[keys.command]]
+key = "alt+l"
+type = "plugin_action"
+command = "herdr-splits.resize-right"
```

After saving, apply without restarting the herdr server:

```bash
herdr server reload-config
```

## Rollout / how to try it

1. Run the `herdr plugin install` command (step 1).
2. Apply the file edits above (steps 2-4) and `:Lazy sync` inside nvim so lazy.nvim
   fetches `herdr-splits.nvim` and picks up the new spec.
3. Apply the config.toml edit (step 5) and `herdr server reload-config`.
4. Fully quit and reopen the nvim instance running inside the herdr pane (`cond` is
   only evaluated at nvim startup, so an already-running nvim won't pick this up).
5. From that nvim, at a split edge, `<C-l>` should cross into the neighboring herdr
   pane; from a plain herdr pane, `<C-h>` should cross back into nvim and land in the
   right window automatically.

## Known gaps (call these out explicitly, don't silently drop)

- No `swap_buf_*` equivalent inside herdr panes (`<leader><leader>h/j/k/l>` — herdr-splits.nvim doesn't implement buffer swapping, only nav+resize).
- `herdr_bin` in `setup()` was left unset (auto-detected via `HERDR_BIN_PATH`, which
  herdr injects into every pane) — confirm that resolves correctly to
  `~/.local/bin/herdr` before trusting the defaults blindly; override explicitly if not.
- The Herdr-side bash scripts this installs do **not** auto-update (`herdr plugin
  install ...` again after any future `:Lazy update` on this plugin, per its README) —
  worth revisiting if the plugin bumps versions later; `auto_sync_herdr = true` +
  a `build` hook is the plugin's own opt-in fix for that but wasn't included above to
  keep this first pass minimal.
