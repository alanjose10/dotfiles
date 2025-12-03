return {
	"christoomey/vim-tmux-navigator",
	lazy = false,
	init = function()
		-- Alt+Arrow navigation (Colemak-friendly and avoids macOS Ctrl+Arrow shortcuts)
		vim.g.tmux_navigator_no_mappings = 1
		vim.keymap.set("n", "<A-Left>", ":TmuxNavigateLeft<CR>", { silent = true, desc = "Tmux go left" })
		vim.keymap.set("n", "<A-Right>", ":TmuxNavigateRight<CR>", { silent = true, desc = "Tmux go right" })
		vim.keymap.set("n", "<A-Up>", ":TmuxNavigateUp<CR>", { silent = true, desc = "Tmux go up" })
		vim.keymap.set("n", "<A-Down>", ":TmuxNavigateDown<CR>", { silent = true, desc = "Tmux go down" })
	end,
}
