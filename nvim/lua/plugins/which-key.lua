return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		"echasnovski/mini.icons",
	},
	opts = {
		win = {
			border = "rounded",
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		wk.add({
			{ "<leader>f", group = "[F]" },
			{ "<leader>g", group = "[G]" },
			{ "<leader>c", group = "[C]" },
			{ "<leader>d", group = "[D]" },
		})
	end,
}
