return {
  "mrjones2014/smart-splits.nvim",
  cond = function()
    return vim.env.HERDR_ENV ~= "1"
  end,
  config = function()
    require("smart-splits").setup({
      -- Ignored filetypes (only while resizing)
      ignored_buftypes = {
        "nofile",
        "quickfix",
        "prompt",
      },
      -- Ignored buffer types (only while resizing)
      ignored_filetypes = { "NvimTree" },
    })
  end,
}
