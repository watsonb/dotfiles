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
