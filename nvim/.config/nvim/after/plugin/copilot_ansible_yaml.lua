require("copilot").setup({
  filetypes = {
    ["yaml.ansible"] = true, -- hail mary?
    ["ansible"] = true, -- in the event we have/use an ansible filetype
  },
  disable_limit_reached_message = true,
})
