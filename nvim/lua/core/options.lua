-- Leader keys
vim.g.mapleader = " " -- set space as the leader key for custom mappings
vim.g.maplocalleader = "\\" -- set backslash as local leader for filetype-specific mappings

-- General options

vim.opt.background = "dark" -- hint to colorschemes to use dark variant
vim.opt.clipboard = "unnamedplus" -- sync system clipboard with vim registers
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.tabstop = 2 -- number of spaces a tab character displays as
vim.opt.softtabstop = 2 -- number of spaces inserted when pressing tab
vim.opt.shiftwidth = 2 -- number of spaces for each indentation level
vim.opt.number = true -- show absolute line numbers
vim.opt.relativenumber = true -- show relative line numbers for easier navigation
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- override ignorecase if search contains uppercase
vim.opt.splitbelow = true -- horizontal splits open below current window
vim.opt.splitright = true -- vertical splits open to the right of current window
vim.opt.swapfile = false -- disable swap files
vim.opt.termguicolors = true -- enable 24-bit RGB colors in the terminal
vim.opt.grepprg = "rg --vimgrep --hidden" -- use ripgrep for :grep command
vim.opt.grepformat = "%f:%l:%c:%m" -- format for parsing grep output
vim.opt.updatetime = 300 -- faster completion and CursorHold events (default 4000ms)
vim.opt.wrap = false -- disable line wrapping

-- prevent text from shifting when signs popup
vim.opt.signcolumn = "yes:1" -- always show exactly 1 sign column (overrides earlier setting)

-- Persistent undo
vim.opt.undofile = true -- save undo history to file for persistence across sessions
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo" -- directory to store undo files

-- Scrolling and cursor
vim.opt.scrolloff = 8 -- minimum lines to keep above/below cursor when scrolling
vim.opt.sidescrolloff = 8 -- minimum columns to keep left/right of cursor
vim.opt.cursorline = true -- highlight the line containing the cursor

-- Command line and status
vim.opt.cmdheight = 0 -- hide command line when not in use (cleaner UI in Neovim 0.10+)
vim.opt.laststatus = 3 -- single global statusline across all windows
vim.opt.showmode = false -- don't show mode in command line (already shown in statusline)

-- Completion menu
vim.opt.pumheight = 15 -- maximum number of items to show in popup menu
vim.opt.completeopt = "menu,menuone,noselect" -- completion behavior: show menu, show for one match, don't auto-select

-- Timeouts
vim.opt.timeoutlen = 300 -- time to wait for mapped sequence to complete (in ms)

-- Mouse support
vim.opt.mouse = "a" -- enable mouse support in all modes

-- Backups
vim.opt.backup = false -- don't create backup files before overwriting
vim.opt.writebackup = false -- don't create backup before writing file

-- Whitespace and separators
vim.opt.fillchars = {
  fold = " ", -- character to show for folded lines
  foldopen = "v", -- character for open fold indicator
  foldclose = ">", -- character for closed fold indicator
  foldsep = " ", -- character for fold column separator
  diff = "╱", -- character to fill deleted lines in diff mode
  eob = " ", -- character for empty lines at end of buffer
}
vim.opt.list = true -- show invisible characters
vim.opt.listchars = {
  tab = "→ ", -- characters to show for tabs
  trail = "·", -- character to show for trailing spaces
  extends = "»", -- character shown when line continues beyond screen right
  precedes = "«", -- character shown when line continues beyond screen left
  nbsp = "␣", -- character to show for non-breaking spaces
}

-- Concealment
vim.opt.conceallevel = 2 -- hide concealed text unless it has a custom replacement
vim.opt.concealcursor = "nc" -- hide concealed text in normal and command mode

-- Smooth scrolling
vim.opt.smoothscroll = true -- scroll by screen lines when wrap is disabled

-- Folding (for nvim-ufo plugin)
vim.opt.foldcolumn = "1" -- show fold column with 1 character width
vim.opt.foldlevel = 99 -- open all folds by default (nvim-ufo will manage this)
vim.opt.foldlevelstart = 99 -- open all folds when opening a file
vim.opt.foldenable = true -- enable folding
