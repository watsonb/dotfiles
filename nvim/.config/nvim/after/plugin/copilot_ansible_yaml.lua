require("copilot").setup({
  filetypes = {
    ["yaml.ansible"] = true, -- hail mary?
    ["ansible"] = true, -- in the event we have/use an ansible filetype
  },
})
