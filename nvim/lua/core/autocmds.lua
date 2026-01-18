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

-- Filetype-specific settings
autocmd("FileType", {
	group = augroup("filetype_settings", { clear = true }),
	pattern = { "go" },
	callback = function()
		vim.opt_local.expandtab = false -- Go uses tabs
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})
