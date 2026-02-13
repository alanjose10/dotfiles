-- Minimal autocommands

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight on yank
autocmd("TextYankPost", {
	group = augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- Remove trailing whitespace on save (skip large files for performance)
autocmd("BufWritePre", {
	group = augroup("trim_whitespace", { clear = true }),
	pattern = "*",
	callback = function()
		local max_lines = 10000
		if vim.api.nvim_buf_line_count(0) > max_lines then
			return
		end
		local pos = vim.api.nvim_win_get_cursor(0)
		vim.cmd([[%s/\s\+$//e]])
		vim.api.nvim_win_set_cursor(0, pos)
	end,
})

-- Return to last edit position
autocmd("BufReadPost", {
	group = augroup("last_position", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local line = mark[1]
		local col = mark[2]
		if line > 0 and line <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, { line, col })
		end
	end,
})

autocmd("ColorScheme", {
	group = augroup("custom_highlights", { clear = true }),
	pattern = "*",
	-- Assign it to the group here:
	callback = function()
		-- Your custom highlight logic
		vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#555555", italic = true })
	end,
})

autocmd("FileType", {
	group = augroup("qf_custom", { clear = true }),
	pattern = "qf",
	callback = function()
		-- Map 'dd' to delete the current line from the list
		vim.keymap.set("n", "dd", function()
			local qf_list = vim.fn.getqflist()
			local cur_line = vim.fn.line(".")
			table.remove(qf_list, cur_line)
			vim.fn.setqflist(qf_list, "r")

			-- Re-open to refresh the view and keep cursor position logic
			vim.cmd(cur_line .. "cfirst")
			vim.cmd("copen")
		end, { buffer = true, desc = "Remove item from quickfix" })
	end,
})

-- Enable comment continuation
autocmd("FileType", {
	group = augroup("comment_continuation", { clear = true }),
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:append("cro")
	end,
})
