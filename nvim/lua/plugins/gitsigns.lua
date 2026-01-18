return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- Shows: "User Name • 3 months ago • Commit Message" at the end of the line
		-- disable it by default
		current_line_blame = false,

		current_line_blame_opts = {
			delay = 300, -- Wait 0.3s before showing (avoids flickering when scrolling)
			virt_text_pos = "eol", -- Show at 'End of Line'
		},

		-- 2. Customize the Gutter Signs (Optional, but looks cleaner)
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
		},

		on_attach = function(bufnr)
			vim.keymap.set(
				"n",
				"<leader>ub",
				":Gitsigns toggle_current_line_blame<CR>",
				{ desc = "Toggle inline blame", buffer = bufnr }
			)
			vim.keymap.set("n", "<leader>uB", ":Gitsigns blame<CR>", { desc = "Git blame file", buffer = bufnr })
		end,
	},
}
