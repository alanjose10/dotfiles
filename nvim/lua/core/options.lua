-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- General options
local opt = vim.opt

opt.background = "dark"
opt.clipboard = "unnamedplus"
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.termguicolors = true
opt.grepprg = "rg --vimgrep --hidden"
opt.grepformat = "%f:%l:%c:%m"
opt.updatetime = 300
opt.wrap = false
