return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- 1. Enable "Ghost Text" Blame
		-- Shows: "User Name • 3 months ago • Commit Message" at the end of the line
		current_line_blame = true,

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
	},
}
