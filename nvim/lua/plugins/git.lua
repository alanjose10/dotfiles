return {
  {
    "lewis6991/gitsigns.nvim",

    -- Plugin loads only if Git is installed
    enabled = vim.fn.executable("git") == 1,

    -- Lazy-load when a file is opened
    event = { "BufReadPre", "BufNewFile" },

    opts = {
      -- Inline blame disabled by default to reduce memory/CPU usage
      -- Toggle with <leader>gt when needed
      current_line_blame = false,
      current_line_blame_opts = {
        delay = 300, -- delay before showing blame (ms)
        virt_text_pos = "eol", -- show at end of line
      },
      -- These characters appear next to lines changed by Git
      signs = {
        add = { text = "▎" }, -- line added
        change = { text = "▎" }, -- line modified
        delete = { text = "▎" }, -- line deleted
        topdelete = { text = "▎" }, -- top part of block deleted
        changedelete = { text = "▎" }, -- changed + deleted
        untracked = { text = "▎" }, -- new file content not staged yet
      },

      -- Same set of signs but for *staged* changes
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "▎" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },

      -- on_attach runs whenever gitsigns attaches to a file buffer
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- Navigation between changes (hunks)
        vim.keymap.set("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, { desc = "Next git hunk", buffer = bufnr })

        vim.keymap.set("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, { desc = "Previous git hunk", buffer = bufnr })

        vim.keymap.set("n", "]H", function()
          gs.nav_hunk("last")
        end, { desc = "Last git hunk", buffer = bufnr })

        vim.keymap.set("n", "[H", function()
          gs.nav_hunk("first")
        end, { desc = "First git hunk", buffer = bufnr })

        -- Git blame keymaps (using <leader>g prefix)
        vim.keymap.set("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, { desc = "Git blame line (full)", buffer = bufnr })

        vim.keymap.set("n", "<leader>gB", ":Gitsigns blame<CR>", { desc = "Git blame file", buffer = bufnr })

        vim.keymap.set(
          "n",
          "<leader>gt",
          ":Gitsigns toggle_current_line_blame<CR>",
          { desc = "Toggle inline blame", buffer = bufnr }
        )

        -- Diff keymaps
        vim.keymap.set("n", "<leader>gd", gs.diffthis, { desc = "Git diff this", buffer = bufnr })

        vim.keymap.set("n", "<leader>gD", function()
          gs.diffthis("~")
        end, { desc = "Git diff against HEAD~", buffer = bufnr })

        vim.keymap.set("n", "<leader>gq", ":diffoff | q<CR>", { desc = "Close diff view", buffer = bufnr })

        -- Preview changes
        vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Preview git hunk", buffer = bufnr })

        -- Show deleted lines
        vim.keymap.set("n", "<leader>gx", gs.toggle_deleted, { desc = "Toggle deleted lines", buffer = bufnr })

        -- Text object for operating on hunks
        vim.keymap.set(
          { "o", "x" },
          "ih",
          ":<C-U>Gitsigns select_hunk<CR>",
          { desc = "Select git hunk", buffer = bufnr }
        )
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" }, -- lazy load on command
    keys = {
      {
        "<leader>gv",
        ":DiffviewOpen<CR>",
        desc = "Open diff view",
      },
      {
        "<leader>gh",
        ":DiffviewFileHistory %<CR>",
        desc = "File history (current file)",
      },
      {
        "<leader>gH",
        ":DiffviewFileHistory<CR>",
        desc = "File history (all files)",
      },
      {
        "<leader>gc",
        ":DiffviewClose<CR>",
        desc = "Close diff view",
      },
    },
    opts = {
      enhanced_diff_hl = true, -- use better diff highlighting
      view = {
        default = {
          layout = "diff2_horizontal", -- side-by-side horizontal split
        },
        merge_tool = {
          layout = "diff3_horizontal", -- 3-way merge view
        },
      },
      file_panel = {
        win_config = {
          width = 35, -- width of file panel
        },
      },
    },
  },
}
