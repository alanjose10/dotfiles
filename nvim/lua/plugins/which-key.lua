-- which-key.nvim - Shows available keybindings in popup
-- Press any leader key and wait to see available options
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.icons",
  },
  opts = {
    preset = "modern", -- modern, classic, or helix
    delay = 300, -- delay before showing popup (ms)
    win = {
      border = "rounded", -- border style
      padding = { 1, 2 }, -- padding [top/bottom, right/left]
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Register only group names (keymaps auto-discovered from plugins)
    wk.add({
      -- Leader key groups
      { "<leader>f", group = "Find (Telescope)" },
      { "<leader>g", group = "Git" },
      { "<leader>c", group = "Code" },
      { "<leader>t", group = "Toggle/Terminal" },
      { "<leader>w", group = "Window" },
      { "<leader>x", group = "Diagnostics (Trouble)" },

      -- Other prefix groups
      { "gs", group = "Surround" },
      { "]", group = "Next" },
      { "[", group = "Previous" },
      { "z", group = "Fold" },
    })
  end,
}
