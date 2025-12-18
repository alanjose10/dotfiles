-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- General options

vim.opt.background = "dark"
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.grepprg = "rg --vimgrep --hidden"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.updatetime = 300
vim.opt.wrap = false

-- prevent text from shifting when signs popup
vim.opt.signcolumn = "yes:1"
