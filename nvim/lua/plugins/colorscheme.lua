-- Colorschemes - change the variable below to switch
local USE = "everforest" -- options: rose-pine, kanagawa, tokyonight, everforest

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		enabled = USE == "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({ variant = "moon" }) -- main, moon, or dawn
			vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		enabled = USE == "kanagawa",
		priority = 1000,
		config = function()
			vim.cmd("colorscheme kanagawa")
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = USE == "tokyonight",
		priority = 1000,
		config = function()
			require("tokyonight").setup({ style = "night" }) -- night, storm, day, moon
			vim.cmd("colorscheme tokyonight")
		end,
	},
	{
		"sainnhe/everforest",
		enabled = USE == "everforest",
		priority = 1000,
		config = function()
			vim.g.everforest_background = "hard" -- hard, medium, soft
			vim.cmd("colorscheme everforest")
		end,
	},
}
