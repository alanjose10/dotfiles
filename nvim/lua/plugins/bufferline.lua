return {
	enabled = false,
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	keys = {
		{ "L", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
		{ "H", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
		{ "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
		{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Delete Other Buffers" },
		{ "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Delete Buffers to the Right" },
		{ "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete Buffers to the Left" },
	},
	opts = {
		options = {
      -- stylua: ignore
      close_command = function(n) require("snacks").bufdelete(n) end,
      -- stylua: ignore
      right_mouse_command = function(n) require("snacks").bufdelete(n) end,
			diagnostics = "nvim_lsp",
			always_show_bufferline = false,
			diagnostics_indicator = function(_, _, diag)
				local icons = {
					Error = " ",
					Warn = " ",
					Hint = " ",
					Info = " ",
				}
				local ret = (diag.error and icons.Error .. diag.error .. " " or "")
					.. (diag.warning and icons.Warn .. diag.warning or "")
				return vim.trim(ret)
			end,
			offsets = {
				{
					filetype = "snacks_layout_box",
					text = "File Explorer",
					highlight = "Directory",
					text_align = "left",
				},
			},
		},
	},
}
