return {
  "stevearc/conform.nvim", -- modern formatting plugin for Neovim
  event = { "BufWritePre" }, -- load plugin just before saving (for format-on-save)
  cmd = { "ConformInfo" }, -- also load when running :ConformInfo command

  -- Keymaps - defined here so they're available immediately (lazy.nvim handles loading)
  keys = {
    {
      "<leader>cf", -- keymap: space + c + f
      function()
        require("conform").format({ lsp_format = "fallback" }) -- format using conform, fall back to LSP if no formatter
      end,
      mode = { "n", "v" }, -- works in normal and visual mode
      desc = "Format buffer", -- description shown in which-key
    },
  },

  opts = {
    -- Define which formatter to use for each filetype
    formatters_by_ft = {
      lua = { "stylua" }, -- use stylua for Lua files
      go = { "gofumpt" }, -- use gofumpt for Go files (stricter than gofmt)
      -- Add more formatters here as needed:
      -- python = { "black" },
      -- javascript = { "prettier" },
    },

    -- Customize formatter behavior by passing command-line arguments
    formatters = {
      stylua = {
        prepend_args = {
          "--indent-type", -- force stylua to use spaces instead of tabs
          "Spaces",
          "--indent-width", -- set indentation width to 2 spaces
          "2",
        },
      },
    },

    -- Automatically format on save
    format_on_save = {
      timeout_ms = 500, -- maximum time to wait for formatting to complete
      lsp_format = "fallback", -- use LSP formatting if no conform formatter is configured
    },
  },
}
