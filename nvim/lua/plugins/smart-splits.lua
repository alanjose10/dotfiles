return {
	"mrjones2014/smart-splits.nvim",
	lazy = false,
	opts = {
		default_amount = 10,
	},
	keys = {
		-- 1. Moving between splits (Alt + Arrows)
		{
			"<M-Left>",
			function()
				require("smart-splits").move_cursor_left()
			end,
			desc = "Move left",
		},
		{
			"<M-Down>",
			function()
				require("smart-splits").move_cursor_down()
			end,
			desc = "Move down",
		},
		{
			"<M-Up>",
			function()
				require("smart-splits").move_cursor_up()
			end,
			desc = "Move up",
		},
		{
			"<M-Right>",
			function()
				require("smart-splits").move_cursor_right()
			end,
			desc = "Move right",
		},

		-- 2. Resizing splits (Alt + Shift + Arrows)
		{
			"<M-S-Left>",
			function()
				require("smart-splits").resize_left()
			end,
			desc = "Resize left",
		},
		{
			"<M-S-Down>",
			function()
				require("smart-splits").resize_down()
			end,
			desc = "Resize down",
		},
		{
			"<M-S-Up>",
			function()
				require("smart-splits").resize_up()
			end,
			desc = "Resize up",
		},
		{
			"<M-S-Right>",
			function()
				require("smart-splits").resize_right()
			end,
			desc = "Resize right",
		},
	},
}
