-- Clear search highlight
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Write / quit
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Close file" })

-- Split helpers
vim.keymap.set("n", "<leader>%", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", '<leader>"', ":split<CR>", { desc = "Horizontal split" })

-- Visual search
vim.keymap.set("v", "*", 'y/\\V<C-R>"<CR>', { desc = "Search selection (forward)" })
vim.keymap.set("v", "#", 'y?\\V<C-R>"<CR>', { desc = "Search selection (backward)" })

-- Open current buffer in new tab and close current window
vim.keymap.set("n", "<leader>tt", function()
	local original_win = vim.api.nvim_get_current_win()
	vim.cmd("tab split")
	vim.api.nvim_win_close(original_win, false)
end, { desc = "Open current buffer in new tab and close the current window" })

-- Navigate quick fix list
vim.keymap.set("n", "<M-Up>", ":cprev<CR>", { desc = "Go to perveous item in quick fix" })
vim.keymap.set("n", "<M-Down>", ":cnext<CR>", { desc = "Go to next item in quick fix" })

vim.keymap.set("n", "<leader>tm", ":terminal<CR>", { desc = "Open terminal" })

require("core.floaterm").setup_keymaps()
