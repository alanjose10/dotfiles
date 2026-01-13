return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    opts = {
    bigfile = {
        enabled = false,
      notify = true,
      line_length = 10000,
    },
  },
    explorer = {
      enabled = true,
      replace_netrw = true, -- Replace netrw with the snacks explorer
      trash = true, -- Use the system trash when deleting files
      -- your explorer configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    picker = {
      sources = {
        explorer = {
        layout = { layout = { position = "left" } },
        -- Default to showing hidden files
        hidden = true,
        -- Don't close the explorer when I open a file (persistent sidebar)
        auto_close = true,
        -- Jump to the file in the explorer when I change buffers
        follow_file = true,
          -- your explorer picker configuration comes here
          -- or leave it empty to use the default settings
        win = {
          list = {
              keys = {
                ["%"] = { "edit_vsplit", mode = { "n", "i" } }, -- vertical split
                ['"'] = { "edit_split", mode = { "n", "i" } }, -- horizontal split
              },
            },
        },
        },

      },
    },
        lazygit = {

    },
    -- disable other stuff
    dashboard = { enabled = false },
    notifier = { enabled = false },
    input = { enabled = false },
    scope = { enabled = false },
    scratch = { enabled = false },
  },
  keys = {
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },

    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep Project" },

    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },

    { "<leader>e", function() Snacks.explorer() end, desc = "Snacks File Explorer" },

    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },

    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },

    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Grep Word Under Cursor", mode = { "n", "x" } },

    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Search Buffer Lines" },

    -- Help: Search help tags (crucial for learning)
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
        { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },

    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = "Search Registers",
    },

    -- UI
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },


-- Opens Lazygit in a floating window
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },

    { "<leader>fq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
  },
}
