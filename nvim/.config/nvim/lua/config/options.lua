-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
-- vim.opt.textwidth = 80
-- vim.opt.tw = 80
vim.opt.cmdheight = 1

vim.opt.smartindent = false

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80,120"

vim.opt.timeoutlen = 1000

vim.opt.list = true
vim.opt.listchars = "eol:$,tab:>-,space:.,trail:~,extends:>,precedes:<"

vim.opt.pumblend = 15
vim.opt.cursorline = true

vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldcolumn = "3"

-- I want my default root to be the current working directory ("cwd") since
-- I don't do monorepo stuff usually and I don't want LazyVim to be overly
-- smart/deterministic about it.
-- vim.g.root_spec = {"lsp", {".git", "lua"}, "cwd"}  -- the default spec
vim.g.root_spec = { "cwd" }

-- ansible-vim
--vim.g.ansible_unindent_after_newline = 1
--vim.g.ansible_yamlKeyName = 'yamlKey'
--vim.g.ansible_attribute_highlight = "n"
vim.g.ansible_name_highlight = "d"
vim.g.ansible_extra_keywords_highlight = 1
vim.g.ansible_extra_keywords_highlight_group = "Structure"
vim.g.ansible_normal_keywords_highlight = "Statement"
vim.g.ansible_loop_keywords_highlight = "Statement"
-- vim.g.ansible_template_syntaxes = { '*.rb.j2': 'ruby', '*.ps1.j2': 'powershell', '*.sh.j2': 'bash' }
-- vim.g.ansible_template_syntaxes = {
--   ["*.rb.j2"] = "ruby",
--   ["*.ps1.j2"] = "powershell",
--   ["*.sh.j2"] = "bash",
-- }
--vim.g.ansible_ftdetect_filename_regex = '\v(playbook|site|main|local|requirements)\.ya?ml$'
--vim.g.ansible_ftdetect_filename_regex = '([\s\S]+)\.ya?ml$'
vim.g.ansible_ftdetect_filename_regex = "([\\S]+)\\.ya?ml$"

-- nvim 0.10 changes from 0.9
-- blinking cursor fix
vim.opt.guicursor = "n-v-c:blinkon500-blinkoff500"

-- disable mini.pairs by Default
vim.g.minipairs_disable = true
