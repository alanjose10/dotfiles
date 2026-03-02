local dev = false

return {
	{
		"alanjose10/scopes.nvim",
		dir = dev and "~/repos/scopes.nvim" or nil,
		branch = "main",
		dependencies = { "folke/snacks.nvim" },
		config = function()
			require("scopes").setup({
				keymaps = {
					open = "<leader>so",
					open_root = "<leader>sO",
				},
			})
		end,
	},
}
