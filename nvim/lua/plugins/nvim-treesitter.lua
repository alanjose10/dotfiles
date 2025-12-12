return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				"bash",
				"dockerfile",
				"go",
				"gomod",
				"gowork",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"toml",
				"vim",
				"vimdoc",
				"yaml",
			},
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
				disable = { "yaml" },
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "NN",
					node_incremental = "n+",
					scope_incremental = "n=",
					node_decremental = "n-",
				},
			},
		})
	end,
}
