local dev = false
local version = "v0.1.0"

return {
	{
		"alanjose10/scopes.nvim",
		dir = dev and "~/repos/scopes.nvim" or nil,
		tag = dev and nil or version,
		dependencies = { "folke/snacks.nvim" },
		config = function()
			require("scopes").setup({
				keymaps = {
					open = "<leader>so",
					open_root = "<leader>sO",
				},
			})
		end,
		-- keys = {
		-- 	{ "<leader>so", desc = "Scope: open at cursor" },
		-- 	{ "<leader>sO", desc = "Scope: open at root" },
		-- },
	},
}
