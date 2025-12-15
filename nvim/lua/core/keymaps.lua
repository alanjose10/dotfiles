local map = vim.keymap.set

-- Clear search highlight
map("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Write / quit
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Close file" })

-- Split helpers
map("n", "<leader>%", ":vsplit<CR>", { desc = "Vertical split" })
map("n", '<leader>"', ":split<CR>", { desc = "Horizontal split" })

-- Visual search
map("v", "*", 'y/\\V<C-R>"<CR>', { desc = "Search selection (forward)" })
map("v", "#", 'y?\\V<C-R>"<CR>', { desc = "Search selection (backward)" })
