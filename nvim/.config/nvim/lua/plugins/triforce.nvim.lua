-- Plugin: gisketch/triforce.nvim
-- Installed via store.nvim

return {
  "gisketch/triforce.nvim",
  dependencies = {
    "nvzone/volt",
  },
  config = function()
    require("triforce").setup({
      -- Optional: Add your configuration here
      custom_languages = {
        ["yaml.ansible"] = { name = "Ansible", icon = "" }, -- nf-seti-yaml
      },
      keymap = {
        show_profile = "<leader>tp", -- Open profile with <leader>tp
      },
    })
  end,
}
