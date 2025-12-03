return {
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
			-- A is option in mac. Make sure it is mapped to Alt in the terminal
			-- Show inline blame or full-file blame
			vim.keymap.set("n", "<A-g>", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle line blame" })
			local function toggle_full_blame()
				local cur_win = vim.api.nvim_get_current_win()
				local cur_buf = vim.api.nvim_get_current_buf()

				-- Gather existing blame windows
				local blame_wins = {}
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "fugitiveblame" then
						table.insert(blame_wins, win)
					end
				end

				if #blame_wins > 0 then
					for _, win in ipairs(blame_wins) do
						pcall(vim.api.nvim_win_close, win, true)
					end
				else
					vim.cmd("Git blame")
				end

				-- Restore focus to the original file window
				if vim.api.nvim_win_is_valid(cur_win) and vim.api.nvim_buf_is_valid(cur_buf) then
					pcall(vim.api.nvim_set_current_win, cur_win)
				end
			end
			vim.keymap.set("n", "<A-G>", toggle_full_blame, { desc = "Toggle Git blame (full file)" })
		end,
	},
}
