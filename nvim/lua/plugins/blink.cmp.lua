return {
	"saghen/blink.cmp",
	version = "*",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			menu = {
				border = "rounded",
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", "source_name", gap = 1 },
					},
				},
			},
			documentation = { auto_show = true },
			ghost_text = { enabled = true },
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		signature = { enabled = true },
		fuzzy = { implementation = "prefer_rust_with_warning" },
		cmdline = {
			enabled = true,
			completion = {
				menu = {
					auto_show = true,
				},
			},
		},
		term = {
			enabled = true,
		},
	},
}
