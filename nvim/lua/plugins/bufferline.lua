return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	opts = {
		options = {
			diagnostics = "nvim_lsp",
			separator_style = "slant",
			offsets = {
				{
					filetype = "neo-tree",
					text = "File Explorer",
					highlight = "Directory",
					separator = true,
				},
			},
			show_buffer_close_icons = false,
			show_close_icon = false,
			always_show_bufferline = true,
			custom_filter = function(buf, buf_nums)
				-- exclude terminal from bufferline tabs
				if vim.bo[buf].buftype == "terminal" then
					return false
				end
				return true
			end,
		},
	},
	keys = {
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },

		{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
		{ "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close buffers to the left" },
		{ "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Close buffers to the right" },
	},
}
