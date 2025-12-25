-- Treesitter - Advanced syntax highlighting and code understanding
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate", -- automatically update parsers on install/update
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      -- Required fields for TSConfig type
      modules = {}, -- list of treesitter modules (empty = use all enabled modules)
      sync_install = false, -- install parsers asynchronously (recommended)
      ignore_install = {}, -- list of parsers to ignore (empty = install all)

      -- List of parsers to install automatically
      ensure_installed = {
        "bash",
        "dockerfile",
        "go",
        "gomod",
        "gowork",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
      },
      auto_install = true, -- automatically install parsers for opened files
      highlight = {
        enable = true, -- enable treesitter-based syntax highlighting
      },
      indent = {
        enable = true, -- enable treesitter-based indentation
        disable = { "yaml" }, -- disable for yaml (better handled by LSP)
      },
      incremental_selection = {
        enable = true, -- enable smart selection expansion
        keymaps = {
          init_selection = "<CR>", -- press Enter to start selecting
          node_incremental = "<CR>", -- press Enter again to expand selection
          node_decremental = "<BS>", -- press Backspace to shrink selection
          scope_incremental = "<Tab>", -- press Tab to expand to outer scope
        },
      },
    })
  end,
}
