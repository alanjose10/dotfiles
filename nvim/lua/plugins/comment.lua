return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	config = function()
		local comment = require("Comment")
		comment.setup({

			padding = true,
			sticky = false,
			ignore = nil,
			toggler = {
				line = "gcc",
				block = "gbc",
			},
			opleader = {
				---Line-comment keymap
				line = "gc",
				---Block-comment keymap
				block = "gb",
			},
			extra = {
				---Add comment on the line above
				above = "gcO",
				---Add comment on the line below
				below = "gco",
				---Add comment at the end of line
				eol = "gcA",
			},
			mappings = {
				---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
				basic = true,
				---Extra mapping; `gco`, `gcO`, `gcA`
				extra = true,
			},
			---Function to call before (un)comment
			pre_hook = nil,
			---Function to call after (un)comment
			post_hook = nil,
		})
	end,
}
