-- Clear search highlight
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Smart quit
-- if buffers > 1: delete current buffer
-- if last buffer: quit
vim.keymap.set("n", "<leader>q", function()
  -- count listed, non-special buffers
  local listed = vim.fn.getbufinfo({ buflisted = 1 })
  local n_listed = #listed
  if n_listed > 0 then
    vim.cmd("bdelete")
    -- else
    -- vim.cmd("confirm quit")
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
vim.keymap.set("n", "<M-S-Down>", ":cnext<CR>", { desc = "Next quickfix item" })
vim.keymap.set("n", "<M-S-Up>", ":cprev<CR>", { desc = "Previous quickfix item" })

-- Window navigation with Alt + arrow keys
vim.keymap.set("n", "<M-Left>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<M-Down>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<M-Up>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<M-Right>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<leader>tm", ":terminal<CR>", { desc = "Open terminal" })

-- setup floaterm
local floatterm = require("core.floaterm")
vim.keymap.set({ "n", "t" }, "<M-t>", floatterm.toggle, { desc = "Toggle floating terminal" })
vim.keymap.set({ "n", "t" }, "<M-S-t>", floatterm.reset, { desc = "Reset floating terminal" })
