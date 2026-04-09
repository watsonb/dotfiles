return {
  "sudormrfbin/cheatsheet.nvim",
  cmd = "Cheatsheet",
  keys = {
    { "<leader>?", "<cmd>Cheatsheet<cr>", desc = "open Cheatsheet" },
  },
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
  },
}
