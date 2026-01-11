return {
  {
    enabled = false,
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" }, -- lazy load on :Telescope command
    tag = "v0.1.9",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope Help tags" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Telescope Search keymaps" },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({ hidden = true, follow = true })
        end,
        desc = "Find files",
      },
      { "<leader>FF", "<cmd>Telescope git_files<cr>", desc = "Git files" },
      { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep string under cursor" },
      {
        "<leader><BS>",
        function()
          require("telescope.builtin").oldfiles({ only_cwd = true })
        end,
        desc = "Telescope Recent files (cwd)",
      },
      { "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume last picker" },
      { "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },
      { "<leader>tr", "<cmd>Telescope registers<cr>", desc = "Registers" },
      -- lsp symbols in buffer
      {
        "<leader>ss",
        function()
          require("telescope.builtin").lsp_document_symbols({})
        end,
        desc = "Telescope Goto Symbol",
      },
    },
    config = function()
      local telescope = require("telescope")

      ---@type telescope.config.Config
      local opts = {
        pickers = {
          find_files = {
            theme = "ivy",
          },
          git_files = {
            theme = "ivy",
          },
          registers = {
            theme = "ivy",
          },
          buffers = {
            theme = "ivy",
          },
        },
        extensions = {
          fzf = {},
        },
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
            horizontal = {
              preview_width = 0.55,
            },
          },
          sorting_strategy = "ascending",
          path_display = { "smart" },
          file_ignore_patterns = {
            ".git/",
            "bazel%-bin",
            "bazel%-out",
            "bazel%-testlogs",
            "plz%-out",
            "node_modules",
            "%.cache",
          },
          dynamic_preview_title = true,
        },
      }
      telescope.setup(opts)

      -- Load fzf extension for better performance
      telescope.load_extension("fzf")

      -- Setup multigrep custom picker
      require("plugins.telescope.multigrep").setup()
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    enabled = false,
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
