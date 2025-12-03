return {
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
			-- A is option in mac. Make sure is is mapped to Alt in the terminal
			vim.keymap.set("n", "<A-g>", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle line blame" })
		end,
	},
}
