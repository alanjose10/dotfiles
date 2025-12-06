-- Utility function to set local indentation
local function set_indent(ts)
	vim.opt_local.expandtab = (ts ~= false)
	vim.opt_local.tabstop = ts
	vim.opt_local.softtabstop = ts
	vim.opt_local.shiftwidth = ts
end

-- Go: use tabs (no expandtab), width 4
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.opt_local.expandtab = false
		set_indent(4)
	end,
})

-- Python: spaces, width 4
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		set_indent(4)
	end,
})

-- JSON / YAML / Helm / Compose: spaces, width 2
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "yaml", "yml", "helm", "docker-compose" },
	callback = function()
		set_indent(2)
	end,
})

-- Bazel/Starlark: spaces, width 4
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "bzl", "starlark" },
	callback = function()
		set_indent(4)
	end,
})
