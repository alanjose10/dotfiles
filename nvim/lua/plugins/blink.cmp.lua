return {
	"saghen/blink.cmp",
	version = "*",
	lazy = false,
	dependencies = {
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
	},
	opts = {
		-- Keymaps
		-- 'default' preset automatically maps:
		--   <C-space> : Open menu
		--   <CR>      : Accept selection
		--   <Tab>     : Next item / Select
		--   <S-Tab>   : Previous item
		keymap = {
			preset = "enter",
			["<C-e>"] = { "hide", "fallback" },
		},

		appearance = {
			use_nvim_cmp_as_default = true, -- Fallback for themes that don't support blink yet
			nerd_font_variant = "mono",
		},

		snippets = { preset = "luasnip" },

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		signature = { enabled = true },

		completion = {
			menu = { border = "single" },
			documentation = {
				auto_show = true,
				window = {
					border = "single",
				},
			},
		},
		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },
		cmdline = {
			enabled = true,
			completion = {
				menu = {
					auto_show = true,
				},
			},
		},
	},
}
