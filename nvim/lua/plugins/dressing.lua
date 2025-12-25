-- dressing.nvim - Better UI for vim.ui.select and vim.ui.input
-- Improves default Neovim prompts with nicer interfaces
--
-- What it improves:
--   - LSP code actions → Prettier selection menu (uses Telescope)
--   - vim.ui.input() → Better input prompts
--   - Rename prompts → Inline rename UI
--   - Any plugin using vim.ui.select() → Better UI
--
-- Examples:
--   - LSP: "Code action" popup is now a nice Telescope menu
--   - LSP: "Rename" shows inline with preview
--   - Any selection list is now prettier

return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      -- Enable input improvements
      enabled = true,
      -- Default prompt string
      default_prompt = "Input",
      -- Trim trailing `:` from prompt
      trim_prompt = true,
      -- Window options
      title_pos = "left",
      -- Floating window config
      relative = "cursor",
      prefer_width = 40,
      width = nil,
      max_width = { 140, 0.9 },
      min_width = { 20, 0.2 },
      border = "rounded",
      -- Options passed to nvim_open_win
      win_options = {
        winblend = 0,
        wrap = false,
        list = true,
        listchars = "precedes:…,extends:…",
        sidescrolloff = 0,
      },
    },
    select = {
      -- Enable select improvements
      enabled = true,
      -- Use Telescope for selections when available
      backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
      -- Trim trailing `:` from prompt
      trim_prompt = true,
      -- Telescope-specific options
      telescope = {
        -- Use dropdown theme for better UX
        theme = "dropdown",
        layout_config = {
          width = 0.8,
          height = 0.8,
        },
      },
      -- Built-in selector options (fallback)
      builtin = {
        show_numbers = true,
        border = "rounded",
        relative = "editor",
        win_options = {
          winblend = 0,
        },
        width = nil,
        max_width = { 140, 0.8 },
        min_width = { 40, 0.2 },
        height = nil,
        max_height = 0.9,
        min_height = { 10, 0.2 },
      },
    },
  },
}
