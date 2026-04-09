-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "[P]roject [V]iew, open netrw file Explorer" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "[p]aste over selected and keep paste content in register" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank selected to buffer clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank selected to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete selection [V] or direction [N]" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Ctrl+c == Esc" })

-- Autosave
vim.keymap.set("n", "<leader>as", "<cmd>ASToggle<CR>", { desc = "[a]uto [s]ave toggle" })

-- Cheatsheet
vim.keymap.set("n", "<leader>?", "<cmd>Cheatsheet<CR>", { desc = "open Cheatsheet" })

-- Git
-- vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "open Git" })

-- Undotree
-- vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })

-- ToggleTerm
vim.keymap.set("n", "<leader>tf", "<CMD>ToggleTerm direction=float<cr>", { desc = "[t]oggleterm [f]loat" })
vim.keymap.set(
  "n",
  "<leader>th",
  "<CMD>ToggleTerm size=10 direction=horizontal<cr>",
  { desc = "[t]oggleterm [h]orizontal" }
)
vim.keymap.set(
  "n",
  "<leader>tv",
  "<CMD>ToggleTerm size=80 direction=vertical<cr>",
  { desc = "[t]oggleterm [v]ertical" }
)
vim.keymap.set("n", "<leader>tt", "<CMD>ToggleTerm direction=tab<cr>", { desc = "[t]oggleterm [t]ab" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = 0, desc = "escape text entry mode in terminal" })
vim.keymap.set(
  "t",
  "<C-w>",
  [[<C-\><C-n><C-w>]],
  { buffer = 0, desc = "escape text entry in terminal and ready to move to window" }
)

-- Trouble
-- Lua
vim.keymap.set(
  "n",
  "<leader>xx",
  "<cmd>Trouble diagnostics toggle<cr>",
  { desc = "Toggle Trouble diagnostics" },
  { silent = true, noremap = true }
)
-- vim.keymap.set(
--   "n",
--   "<leader>xw",
--   "<cmd>TroubleToggle workspace_diagnostics<cr>",
--   { desc = "Toggle Trouble (workspace)" },
--   { silent = true, noremap = true }
-- )
-- vim.keymap.set(
--   "n",
--   "<leader>xd",
--   "<cmd>TroubleToggle document_diagnostics<cr>",
--   { desc = "Toggle Trouble (document)" },
--   { silent = true, noremap = true }
-- )
-- vim.keymap.set(
--   "n",
--   "<leader>xl",
--   "<cmd>TroubleToggle loclist<cr>",
--   { desc = "Toggle Trouble location list" },
--   { silent = true, noremap = true }
-- )
-- vim.keymap.set(
--   "n",
--   "<leader>xq",
--   "<cmd>TroubleToggle quickfix<cr>",
--   { desc = "Toggle Trouble quickfix" },
--   { silent = true, noremap = true }
-- )
-- vim.keymap.set(
--   "n",
--   "gR",
--   "<cmd>TroubleToggle lsp_references<cr>",
--   { desc = "Toggle Trouble LSP References" },
--   { silent = true, noremap = true }
-- )

-- smart splits
-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left, { desc = "resize left" })
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down, { desc = "resize down" })
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up, { desc = "resize up" })
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right, { desc = "resize right" })
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "move cursor left" })
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "move cursor down" })
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "move cursor up" })
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "move cursor right" })
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left, { desc = "swap buffer left" })
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down, { desc = "swap buffer down" })
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up, { desc = "swap buffer up" })
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right, { desc = "swap buffer right" })

-- venv select
-- vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "[v]env [s]elect" })
-- vim.keymap.set("n", "<leader>vc", "<cmd>VenvSelectCached<cr>", { desc = "[v]envselect [c]ached" })

-- Harpoon
-- Try using Harpoon2 via lazyvim extras and their stock keymaps
-- vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "Harpoon add buffer" })
-- vim.keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu, { desc = "Harpoon open UI" })
-- vim.keymap.set("n", "<leader>h1", function()
--   require("harpoon.ui").nav_file(1)
-- end, { desc = "Harpoon goto file 1" })
-- vim.keymap.set("n", "<leader>h2", function()
--   require("harpoon.ui").nav_file(2)
-- end, { desc = "Harpoon goto file 2" })
-- vim.keymap.set("n", "<leader>h3", function()
--   require("harpoon.ui").nav_file(3)
-- end, { desc = "Harpoon goto file 3" })
-- vim.keymap.set("n", "<leader>h4", function()
--   require("harpoon.ui").nav_file(4)
-- end, { desc = "Harpoon goto file 4" })
-- vim.keymap.set("n", "<leader>h5", function()
--   require("harpoon.ui").nav_file(5)
-- end, { desc = "Harpoon goto file 5" })
-- vim.keymap.set("n", "<leader>h6", function()
--   require("harpoon.ui").nav_file(6)
-- end, { desc = "Harpoon goto file 6" })
-- vim.keymap.set("n", "<leader>h7", function()
--   require("harpoon.ui").nav_file(7)
-- end, { desc = "Harpoon goto file 7" })
-- vim.keymap.set("n", "<leader>h8", function()
--   require("harpoon.ui").nav_file(8)
-- end, { desc = "Harpoon goto file 8" })
-- vim.keymap.set("n", "<leader>h9", function()
--   require("harpoon.ui").nav_file(9)
-- end, { desc = "Harpoon goto file 9" })
-- vim.keymap.set("n", "<leader>hn", function()
--   require("harpoon.ui").nav_next()
-- end, { desc = "Harpoon goto next file" })
-- vim.keymap.set("n", "<leader>hp", function()
--   require("harpoon.ui").nav_prev()
-- end, { desc = "Harpoon goto prev file" })

--Rest.nvim
--Not using rest.nvim in favor of new kalua rest client configured via lazy extras
-- vim.keymap.set("n", "<leader>rr", "<CMD>Rest run<cr>", { desc = "Run rest request under cursor" })
-- vim.keymap.set("n", "<leader>rl", "<CMD>Rest run last<cr>", { desc = "Re-Run last rest request" })

-- strudel
-- local strudel = require("strudel")
-- vim.keymap.set("n", "<leader><leader>sl", strudel.launch, { desc = "Launch Strudel" })
-- vim.keymap.set("n", "<leader><leader>sq", strudel.quit, { desc = "Quit Strudel" })
-- vim.keymap.set("n", "<leader><leader>st", strudel.toggle, { desc = "Toggle Strudel Play/Stop" })
-- vim.keymap.set("n", "<leader><leader>su", strudel.update, { desc = "Update Strudel" })
-- vim.keymap.set("n", "<leader><leader>ss", strudel.stop, { desc = "Stop Strudel" })
-- vim.keymap.set("n", "<leader><leader>sb", strudel.set_buffer, { desc = "Set Strudel to current buffer" })
-- vim.keymap.set("n", "<leader><leader>sx", strudel.execute, { desc = "Set Strudel to current buffer and update" })
