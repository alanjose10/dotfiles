-- Essential keymaps

-- Clear search highlight
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window navigation
vim.keymap.set("n", "<A-Left>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<A-Down>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<A-Up>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<A-Right>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffer navigation
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- Better indenting (stay in visual mode)
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move lines
vim.keymap.set("n", "<A-S-Down>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-S-Up>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-S-Left>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Navigate quick fix list
vim.keymap.set("n", "<M-S-Right>", ":cnext<CR>", { desc = "Quickfix: Next item" })
vim.keymap.set("n", "<M-S-Left>", ":cprev<CR>", { desc = "Quickfix: Previous item" })

vim.keymap.set("n", "<leader>us", function()
	vim.opt.spell = not (vim.opt.spell:get())
end, { desc = "Toggle Spell Check" })

vim.keymap.set("n", "<leader>%", "<cmd>vsplit<cr>", { desc = "Vertical spilt" })
vim.keymap.set("n", '<leader>"', "<cmd>split<cr>", { desc = "Horizontal spilt" })

-- Paste on a new line (Force Linewise)
vim.keymap.set("n", "]p", "<cmd>pu<cr>", { desc = "Paste below line" })
vim.keymap.set("n", "[p", "<cmd>pu!<cr>", { desc = "Paste above line" })

vim.keymap.set("n", "*", vim.lsp.buf.document_highlight, { desc = "Smart Highlight (*)" })
