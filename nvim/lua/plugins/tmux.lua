return {
	"mrjones2014/smart-splits.nvim",
	lazy = false,
	config = function()
		local ss = require("smart-splits")
		ss.setup({
			-- Use tmux when available for cross-pane movement
			multiplexer_integration = "tmux",
		})

		local maps = {
			{ "<leader><Left>", ss.move_cursor_left, "Go to left pane" },
			{ "<leader><Right>", ss.move_cursor_right, "Go to rigth pane" },
			{ "<leader><Up>", ss.move_cursor_up, "Go to top pane" },
			{ "<leader><Down>", ss.move_cursor_down, "Go to bottom pane" },
		}
		for _, m in ipairs(maps) do
			vim.keymap.set("n", m[1], m[2], { desc = m[3] })
		end
	end,
}
