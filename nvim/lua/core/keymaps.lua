-- Essential keymaps

-- Clear search highlight
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window management
vim.keymap.set("n", "<leader>wm", "<cmd>wincmd |<cr><cmd>wincmd _<cr>", { desc = "Maximize window" })
vim.keymap.set("n", "<leader>w=", "<cmd>wincmd =<cr>", { desc = "Equalize windows" })
vim.keymap.set("n", "<leader>%", "<cmd>vsplit<cr>", { desc = "Vertical spilt" })
vim.keymap.set("n", '<leader>"', "<cmd>split<cr>", { desc = "Horizontal spilt" })

-- Better indenting (stay in visual mode)
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

vim.keymap.set("n", "<leader>us", function()
	vim.opt.spell = not (vim.opt.spell:get())
end, { desc = "Toggle Spell Check" })

-- Paste on a new line (Force Linewise)
vim.keymap.set("n", "]p", "<cmd>pu<cr>", { desc = "Paste below line" })
vim.keymap.set("n", "[p", "<cmd>pu!<cr>", { desc = "Paste above line" })

vim.keymap.set("n", "*", vim.lsp.buf.document_highlight, { desc = "Smart Highlight (*)" })

-- Toggle line wrap
vim.keymap.set("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle Line Wrap" })

-- Buffer management
vim.keymap.set("n", "<leader>bo", function()
	local curr = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= curr and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
			vim.api.nvim_buf_delete(buf, { force = false })
		end
	end
end, { desc = "Delete other buffers" })
