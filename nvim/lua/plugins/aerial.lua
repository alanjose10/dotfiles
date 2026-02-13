return {
	"stevearc/aerial.nvim",
	event = "VeryLazy",
	opts = function()
		local icons = {
			Array = " ",
			Boolean = "󰨙 ",
			Class = " ",
			Codeium = "󰘦 ",
			Color = " ",
			Control = " ",
			Collapsed = " ",
			Constant = "󰏿 ",
			Constructor = " ",
			Copilot = " ",
			Enum = " ",
			EnumMember = " ",
			Event = " ",
			Field = " ",
			File = " ",
			Folder = " ",
			Function = "󰊕 ",
			Interface = " ",
			Key = " ",
			Keyword = " ",
			Method = "󰊕 ",
			Module = " ",
			Namespace = "󰦮 ",
			Null = " ",
			Number = "󰎠 ",
			Object = " ",
			Operator = " ",
			Package = " ",
			Property = " ",
			Reference = " ",
			Snippet = " ",
			String = " ",
			Struct = "󰆼 ",
			TabNine = "󰏚 ",
			Text = " ",
			TypeParameter = " ",
			Unit = " ",
			Value = " ",
			Variable = "󰀫 ",
		}

		local opts = {
			keymaps = {
				["q"] = "actions.close",
				["<Esc>"] = "actions.close",
				["{"] = "actions.prev",
				["}"] = "actions.next",
			},
			lazy_load = true,
			attach_mode = "global",
			backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
			show_guides = true,
			layout = {
				default_direction = "right",
				resize_to_content = true,
				win_opts = {
					winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
					signcolumn = "yes",
					statuscolumn = " ",
				},
				-- max_width = { 40, 0.2 },
				min_width = 40,
			},
			close_automatic_events = {
				"switch_buffer",
				"unsupported",
			},
			disable_max_lines = 20000,
			disable_max_size = 2000000, -- 2MB
			filter_kind = false, -- Show all symbols
			highlight_on_hover = true,
			icons = icons,
			guides = {
				mid_item = "├╴",
				last_item = "└╴",
				nested_top = "│ ",
				whitespace = "  ",
			},
			on_attach = function(bufnr)
				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,
		}
		return opts
	end,
	keys = {
		{ "<leader>a", "<cmd>AerialToggle<cr>", desc = "Aerial (Outline)" },
	},
}
