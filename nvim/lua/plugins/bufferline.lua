return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	-- config = function()
	-- 	local status_ok, bufferline = pcall(require, "bufferline")
	-- 	if not status_ok then
	-- 		return
	-- 	end
	-- 	vim.opt.termguicolors = true
	-- 	bufferline.setup({})
	-- end,
	event = "VeryLazy",
	opts = {
		options = {
			-- Show only the filename, not the full path
			name_formatter = function(buf)
				return vim.fn.fnamemodify(buf.path, ":t")
			end,

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
		},
	},
	keys = {
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },

		{ "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
		{ "<leader>bc", "<cmd>bdelete<cr>", desc = "Close buffer" },

		{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
		{ "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close buffers to the left" },
		{ "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Close buffers to the right" },
	},
}
