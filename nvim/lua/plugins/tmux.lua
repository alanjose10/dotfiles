return {
	"mrjones2014/smart-splits.nvim",
	lazy = false,
	config = function()
		local ss = require("smart-splits")
		ss.setup({
			-- Use tmux when available for cross-pane movement
			multiplexer_integration = "tmux",
		})

		-- Alt/Meta arrows for movement (works in Vim splits and tmux panes)
		local maps = {
			{ "<A-Left>", ss.move_cursor_left, "Pane left" },
			{ "<A-Right>", ss.move_cursor_right, "Pane right" },
			{ "<A-Up>", ss.move_cursor_up, "Pane up" },
			{ "<A-Down>", ss.move_cursor_down, "Pane down" },
			{ "<M-Left>", ss.move_cursor_left, "Pane left" },
			{ "<M-Right>", ss.move_cursor_right, "Pane right" },
			{ "<M-Up>", ss.move_cursor_up, "Pane up" },
			{ "<M-Down>", ss.move_cursor_down, "Pane down" },
		}

		for _, m in ipairs(maps) do
			vim.keymap.set("n", m[1], m[2], { desc = m[3] })
		end
	end,
}
