return {
  "Kurren123/mssql.nvim",
  -- optional. You also need to call set_keymaps (see below)
  dependencies = { "folke/which-key.nvim" },
  config = function()
    -- require("mssql").setup()
    -- require("mssql").set_keymaps("<leader>D")
    local mssql = require("mssql")
    mssql.setup({
      max_column_width = 1000,
    }, function()
      mssql.set_keymaps("<leader>D")
    end)
  end,
}
