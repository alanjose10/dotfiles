return {
	{
		"numToStr/Comment.nvim",
		config = function()
			local comment = require("Comment")
			comment.setup({
				-- Use line comments everywhere; no block toggles
				toggler = {
					line = "<leader>/",
				},
				opleader = {
					line = "<leader>/",
				},
				---Ensure visual selections comment linewise instead of blockwise
				pre_hook = function(ctx)
					if ctx.ctype == require("Comment.utils").ctype.block then
						ctx.ctype = require("Comment.utils").ctype.line
					end
				end,
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
