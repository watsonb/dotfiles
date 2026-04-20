return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
  version = false, -- last release is way too old and doesn't work on Windows
  opts = {
    highlight = {
      enable = true,
      disable = { "yaml" },
    },
  },
}
