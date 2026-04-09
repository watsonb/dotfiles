-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
vim.cmd("autocmd BufRead,BufNewFile *.{yaml,yml} set filetype=yaml.ansible")
vim.cmd("autocmd FileType yaml.ansible setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>")

vim.api.nvim_create_user_command("Google", function(o)
  -- local escaped = require('socket.url').escape(o.args)
  local escaped = vim.uri_encode(o.args)
  local url = ("https://www.google.com/search?q=%s"):format(escaped)
  vim.ui.open(url)
end, { nargs = 1, desc = "just google it" })
