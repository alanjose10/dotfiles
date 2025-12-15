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
-- also set options local to terminal and keymapping to exit out of terminal mode.
vim.api.nvim_create_autocmd("TermOpen", {
	group = group,
	callback = function(ev)
		-- don't show line numbers in terminal
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"

		-- Jump straight into terminal input
		vim.cmd("startinsert")

		vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {
			desc = "Exit terminal mode",
			buffer = ev.buf,
		})

		vim.keymap.set("t", "<Esc>q", "<C-\\><C-n>:bd!<CR>", {
			desc = "Exit terminal mode and quit terminal",
			buffer = ev.buf,
		})
	end,
})
