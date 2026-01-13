return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	lazy = false,
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	opts = {
		auto_install = true,
		-- Always keep these installed because they are needed for Neovim itself.
		ensure_installed = {
			"bash",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
		},

		-- Highlighting:
		-- The core feature. Makes code look correct.
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false, -- Turn off standard vim syntax (faster)
		},

		-- Indentation:
		-- Replaces the old 'filetype indent on' with smarter, syntax-aware indentation.
		indent = { enable = true },

		-- Incremental selection
		incremental_selection = {
			enable = true, -- enable smart selection expansion
			keymaps = {
				init_selection = "<CR>", -- press Enter to start selecting
				node_incremental = "<CR>", -- press Enter again to expand selection
				node_decremental = "<BS>", -- press Backspace to shrink selection
				scope_incremental = "<Tab>", -- press Tab to expand to outer scope
			},
		},
	},
	-- Pass the options to the setup function
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
