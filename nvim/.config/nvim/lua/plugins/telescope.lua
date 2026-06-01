return {
  "nvim-telescope/telescope.nvim",
  config = function()
    require("telescope").setup({
      defaults = {
        preview = {
          treesitter = false,
        },
      },
    })
  end,
}
