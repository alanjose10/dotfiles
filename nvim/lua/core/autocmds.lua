local group = vim.api.nvim_create_augroup("core_autocmds", { clear = true })

-- Highlight on yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Highlight on yank",
})

-- Restore cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
	group = group,
	callback = function(event)
		-- Don't apply to gitcommit, gitrebase, or special buffers
		if vim.tbl_contains({ "gitcommit", "gitrebase", "svn" }, vim.bo[event.buf].filetype) then
			return
		end

		-- Get the cursor mark
		local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(event.buf)

		-- Check that the mark is within the file
		if mark[1] > 0 and mark[1] <= line_count then
			-- Protected call to avoid errors on weird buffers
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
	desc = "Restore cursor position after reopening file",
})

-- Automatically go to terminal mode when terminal opens
vim.api.nvim_create_autocmd("TermOpen", {
	group = group,
	callback = function(ev)
		local shell = vim.env.SHELL
		if ev.file:sub(-#shell) == shell then
			vim.cmd("startinsert")
			vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {
				desc = "Exit terminal mode",
				buffer = ev.buf,
			})

			vim.keymap.set("t", "<Esc>q", "<C-\\><C-n>:bd!<CR>", {
				desc = "Exit terminal mode and quit terminal",
				buffer = ev.buf,
			})
		end
	end,
})

-- On toggling the terminal back into view, autmatically set it to insert mode
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = group,
	callback = function(ev)
		local shell = vim.env.SHELL
		if ev.file:sub(-#shell) == shell then
			local ft = require("core.floaterm")
			-- Here we need to also chech if the term buffer was opened is the floating window.
			-- If not, we don't go into insert mode.
			if ft.is_floaterm_win(vim.api.nvim_get_current_win()) then
				vim.cmd("startinsert")
			end
		end
	end,
})
