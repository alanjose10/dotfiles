local group = vim.api.nvim_create_augroup("core_autocmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Highlight on yank",
})
