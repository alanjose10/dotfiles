-- Minimal Neovim Configuration
-- Add plugins one by one to debug performance issues

-- Set leader keys before loading anything else
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load core configuration
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy-v2/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim (plugins directory is empty by default)
require("lazy").setup("plugins", {
	root = vim.fn.stdpath("data") .. "/lazy-v2", -- separate plugin directory
	lockfile = vim.fn.stdpath("config") .. "/lazy-lock-v2.json",
	install = {
		colorscheme = { "default" },
	},
	checker = {
		enabled = false, -- don't auto-check for updates
	},
	change_detection = {
		enabled = false, -- don't auto-reload on config change
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
