return {
  "nikitathomas342/lazyk9s.nvim",
  cmd = {
    "LazyK9s",
  },
  keys = {
    {
      "<leader>lk",
      ":LazyK9s<cr>",
      desc = "Lazy K9S",
      mode = { "n", "v" },
    },
  },

  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
