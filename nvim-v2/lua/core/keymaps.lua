-- Essential keymaps

local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window navigation
map("n", "<A-Left>", "<C-w>h", { desc = "Move to left window" })
map("n", "<A-Down>", "<C-w>j", { desc = "Move to window below" })
map("n", "<A-Up>", "<C-w>k", { desc = "Move to window above" })
map("n", "<A-Right>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move lines
map("n", "<A-S-Down>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-S-Up>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-S-Left>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Navigate quick fix list
map("n", "<M-S-Right>", ":cnext<CR>", { desc = "Quickfix: Next item" })
map("n", "<M-S-Left>", ":cprev<CR>", { desc = "Quickfix: Previous item" })
