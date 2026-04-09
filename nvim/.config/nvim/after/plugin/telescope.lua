local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "[P]roject [F]ind (fuzzy) files" })
vim.keymap.set("n", "<leader>pl", builtin.live_grep, { desc = "[P]roject [L]ive grep" })
--vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Fuzzy find in git files (only)" })
--vim.keymap.set('n', '<leader>ps', function()
--	builtin.grep_string({ search = vim.fn.input("Grep > ") });
--end)
vim.keymap.set("n", "<leader>ps", builtin.grep_string, { desc = "[P]roject [S]earch current word" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>/", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer]" })
