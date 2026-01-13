-- Create augroup for filetype-specific settings
local group = vim.api.nvim_create_augroup("filetype_settings", { clear = true })

-- Utility function to set local indentation
local function set_indent(ts)
	vim.opt_local.expandtab = (ts ~= false)
	vim.opt_local.tabstop = ts
	vim.opt_local.softtabstop = ts
	vim.opt_local.shiftwidth = ts
end

-- Go: use tabs (no expandtab), width 4
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = "go",
	callback = function()
		vim.opt_local.expandtab = false
		set_indent(4)
	end,
	desc = "Set Go indentation (tabs, width 4)",
})

-- Python: spaces, width 4
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = "python",
	callback = function()
		set_indent(4)
	end,
	desc = "Set Python indentation (spaces, width 4)",
})

-- JSON / YAML / Helm / Compose: spaces, width 2
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = { "json", "yaml", "yml", "helm", "docker-compose" },
	callback = function()
		set_indent(2)
	end,
	desc = "Set JSON/YAML indentation (spaces, width 2)",
})

-- Bazel/Starlark: spaces, width 4
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = { "bzl", "starlark" },
	callback = function()
		set_indent(4)
	end,
	desc = "Set Bazel/Starlark indentation (spaces, width 4)",
})
