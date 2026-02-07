-- Sensible defaults

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs and indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes:1"
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.smoothscroll = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- System
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.confirm = true -- ask for confirmation
vim.opt.spell = true
vim.opt.jumpoptions = "view,stack"

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Completion
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.pumheight = 10

-- Command Line Completion
vim.opt.wildmenu = true
vim.opt.wildoptions = "pum" -- "pum" stands for Popup Menu
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
