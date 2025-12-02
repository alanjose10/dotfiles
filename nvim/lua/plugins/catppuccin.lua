return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			term_colors = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				mason = true,
				neotree = true,
				telescope = true,
				treesitter = true,
				which_key = true,
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
