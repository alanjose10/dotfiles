return {
  {
    "numToStr/Comment.nvim",
    config = function()
      local comment = require("Comment")
      comment.setup({
        -- Required fields for CommentConfig type
        padding = true, -- add space between comment and line
        sticky = true, -- cursor stays at position after commenting

        ---LHS of toggle mappings in NORMAL mode
        toggler = {
          ---Line-comment toggle keymap
          line = "gcc",
          ---Block-comment toggle keymap
          block = "gbc",
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          ---Line-comment keymap (for motions like gc3j)
          line = "gc",
          ---Block-comment keymap
          block = "gb",
        },
        ---Disable extra mappings (using simpler <leader>/ instead)
        extra = {
          above = "gcO",
          below = "gco",
          eol = "gcA",
        },
        ---Enable keybindings
        mappings = {
          ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
          basic = true,
          ---Disable extra mappings
          extra = true,
        },
      })

      -- Simple toggle with <leader>/ (works in normal and visual mode)
      local api = require("Comment.api")

      -- Normal mode: toggle current line
      vim.keymap.set("n", "<leader>/", api.toggle.linewise.current, { desc = "Toggle comment" })

      -- Visual mode: toggle selection
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
      vim.keymap.set("x", "<leader>/", function()
        vim.api.nvim_feedkeys(esc, "nx", false)
        api.toggle.linewise(vim.fn.visualmode())
      end, { desc = "Toggle comment (selection)" })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function(_, opts)
      require("todo-comments").setup(opts)
      -- Telescope-powered TODO search
      vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find TODOs" })
    end,
  },
}
