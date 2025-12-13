return {
	{
		"numToStr/Comment.nvim",
		config = function()
			local comment = require("Comment")
			comment.setup({
				---LHS of toggle mappings in NORMAL mode
				toggler = {
					---Line-comment toggle keymap
					line = "gcc",
					---Block-comment toggle keymap
					block = "gbc",
				},
				---LHS of operator-pending mappings in NORMAL and VISUAL mode
				opleader = {
					---Line-comment keymap
					line = "gc",
					---Block-comment keymap
					block = "gb",
				},
				---LHS of extra mappings
				extra = {
					---Add comment on the line above
					above = "gcO",
					---Add comment on the line below
					below = "gco",
					---Add comment at the end of line
					eol = "gcA",
				},
				---Enable keybindings
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
				---Ensure visual selections comment linewise instead of blockwise
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		config = function(_, opts)
			require("todo-comments").setup(opts)
			-- Telescope-powered TODO search
			vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find TODOs" })
		end,
	},
}
