return {
	"lewis6991/gitsigns.nvim",

	-- Plugin loads only if Git is installed
	enabled = vim.fn.executable("git") == 1,

	-- Lazy-load when a file is opened
	event = { "BufReadPre", "BufNewFile" },

	opts = {
		-- These characters appear next to lines changed by Git
		signs = {
			add = { text = "▎" }, -- line added
			change = { text = "▎" }, -- line modified
			delete = { text = "▎" }, -- line deleted
			topdelete = { text = "▎" }, -- top part of block deleted
			changedelete = { text = "▎" }, -- changed + deleted
			untracked = { text = "▎" }, -- new file content not staged yet
		},

		-- Same set of signs but for *staged* changes
		signs_staged = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "▎" },
			topdelete = { text = "▎" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},

		-- on_attach runs whenever gitsigns attaches to a file buffer
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			vim.keymap.set(
				"n",
				"<M-g>",
				":Gitsigns toggle_current_line_blame<CR>",
				{ desc = "Toggle line blame", buffer = bufnr }
			)
			vim.keymap.set("n", "<M-G>", ":Gitsigns blame<CR>", { desc = "Toggle file blame", buffer = bufnr })
		end,
	},
}
