-- Essential keymaps

-- Clear search highlight
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window navigation
vim.keymap.set("n", "<A-Left>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<A-Down>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<A-Up>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<A-Right>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
vim.keymap.set("n", "<A-S-Up>", "<cmd>resize +5<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<A-S-Down>", "<cmd>resize -5<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<A-S-Left>", "<cmd>vertical resize -5<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<A-S-Right>", "<cmd>vertical resize +5<CR>", { desc = "Increase window width" })

-- Window management
vim.keymap.set("n", "<leader>wm", "<cmd>wincmd |<cr><cmd>wincmd _<cr>", { desc = "Maximize window" })
vim.keymap.set("n", "<leader>w=", "<cmd>wincmd =<cr>", { desc = "Equalize windows" })

-- Better indenting (stay in visual mode)
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Navigate quick fix list
vim.keymap.set("n", "<leader><Up>", ":cnext<CR>", { desc = "Quickfix: Next item" })
vim.keymap.set("n", "<leader><Down>", ":cprev<CR>", { desc = "Quickfix: Previous item" })

vim.keymap.set("n", "<leader>us", function()
	vim.opt.spell = not (vim.opt.spell:get())
end, { desc = "Toggle Spell Check" })

vim.keymap.set("n", "<leader>%", "<cmd>vsplit<cr>", { desc = "Vertical spilt" })
vim.keymap.set("n", '<leader>"', "<cmd>split<cr>", { desc = "Horizontal spilt" })

-- Paste on a new line (Force Linewise)
vim.keymap.set("n", "]p", "<cmd>pu<cr>", { desc = "Paste below line" })
vim.keymap.set("n", "[p", "<cmd>pu!<cr>", { desc = "Paste above line" })

vim.keymap.set("n", "*", vim.lsp.buf.document_highlight, { desc = "Smart Highlight (*)" })

-- Toggle line wrap
vim.keymap.set("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle Line Wrap" })
