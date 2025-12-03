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
			{ "<leader>b", group = "[B]uffer" },
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>d", group = "[D]ebug" },
			{ "<leader>f", group = "[F]ind" },
			{ "<leader>g", group = "[G]it" },
			{ "<leader>h", group = "[H]arpoon" },
			{ "<leader>w", group = "[W]rite" },
		})
	end,
}
