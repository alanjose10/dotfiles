return {
	{
		enabled = false,
		dir = "~/repos/scopes.nvim",
		config = function()
			require("scopes").setup()
		end,
	},
	{
		enabled = true,
		"alanjose10/scopes.nvim",
		tag = "v0.1.0",
		dependencies = { "folke/snacks.nvim" },
		config = function()
			require("scopes").setup()
		end,
	},
}
