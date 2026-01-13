-- Trouble.nvim - Better diagnostics, quickfix, and references UI
-- A pretty list for showing diagnostics, references, telescope results, etc.
--
-- USAGE:
--   <leader>xx - Toggle trouble
--   <leader>xd - Document diagnostics
--   <leader>xw - Workspace diagnostics
--   <leader>xq - Quickfix list
--   <leader>xl - Location list
--   ]t / [t    - Next/previous trouble item

return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xd",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer diagnostics (Trouble)",
    },
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>xl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP definitions/references (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location list (Trouble)",
    },
    {
      "<leader>xq",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix list (Trouble)",
    },
    {
      "]t",
      function()
        require("trouble").next({ skip_groups = true, jump = true })
      end,
      desc = "Next trouble item",
    },
    {
      "[t",
      function()
        require("trouble").prev({ skip_groups = true, jump = true })
      end,
      desc = "Previous trouble item",
    },
  },
  opts = {
    modes = {
      -- Customize the diagnostics mode
      diagnostics = {
        auto_open = false, -- don't auto open
        auto_close = false, -- don't auto close
      },
    },
    -- Icons for different severity levels
    icons = {
      indent = {
        middle = "├╴",
        last = "└╴",
        top = "│ ",
        ws = "  ",
      },
    },
  },
}
