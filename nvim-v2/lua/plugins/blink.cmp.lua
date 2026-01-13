return {
	"saghen/blink.cmp",
	version = "*",
	lazy = false,
	dependencies = "rafamadriz/friendly-snippets",

	opts = {
		-- Keymaps
		-- 'default' preset automatically maps:
		--   <C-space> : Open menu
		--   <CR>      : Accept selection
		--   <Tab>     : Next item / Select
		--   <S-Tab>   : Previous item
		keymap = { preset = "default" },

		-- Appearance
		appearance = {
			use_nvim_cmp_as_default = true, -- Fallback for themes that don't support blink yet
			nerd_font_variant = "mono",
		},

		-- Sources
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		-- Signature Help (Popup showing function arguments)
		signature = { enabled = true },

		-- Command Line Completion (The ":" menu)
		-- This enables the nice fuzzy menu when you type ":"
		completion = {
			menu = { border = "single" },
			documentation = { window = { border = "single" } },
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
