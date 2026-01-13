-- Only bother doing anything if we're actually inside tmux
if not vim.env.TMUX then
	return
end

local augroup = vim.api.nvim_create_augroup("tmux_window_renaming", { clear = true })

-- When leaving Neovim, restore tmux automatic rename
vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		vim.system({ "tmux", "set-window-option", "automatic-rename", "on" })
	end,
	group = augroup,
	desc = "Turn tmux automatic window renaming on",
})

-- When changing directory, rename the tmux window to "$cwd:nvim"
vim.api.nvim_create_autocmd("DirChanged", {
	callback = function()
		local cwd = vim.v.event.cwd or vim.uv.cwd()
		local name = vim.fs.basename(cwd or "")
		vim.system({ "tmux", "rename-window", name .. ":nvim" })
	end,
	group = augroup,
	desc = "Rename the tmux window to $cwd:nvim",
})
