return {
  "olimorris/onedarkpro.nvim",
  priority = 1000,
  config = function()
    require("onedarkpro").setup({
      options = {
        cursorline = true,
        transparency = true,
      },
      filetypes = {
        javascript = true,
        lua = true,
        markdown = true,
        php = true,
        python = true,
        ruby = true,
        rust = true,
        toml = true,
        typescript = true,
        typescriptreact = true,
        vue = true,
        yaml = false,
      },
    })
    vim.cmd("colorscheme onedark")
  end,
}
