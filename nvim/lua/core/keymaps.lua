-- Clear search highlight
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Smart quit
-- if buffers > 1: delete current buffer
-- if last buffer: quit
vim.keymap.set("n", "<leader>q", function()
	-- count listed, non-special buffers
	local listed = vim.fn.getbufinfo({ buflisted = 1 })
	local n_listed = #listed
	if n_listed > 1 then
		vim.cmd("bdelete")
	else
		vim.cmd("confirm quit")
	end
end, { desc = "Close buffer" })

-- Quit window (only closes the current split)
vim.keymap.set("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close window" })

-- Quit Neovim (all windows)
vim.keymap.set("n", "<leader>Q", "<cmd>confirm qall<CR>", { desc = "Quit all (confirm)" })

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
