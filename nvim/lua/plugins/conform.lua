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
      lua = { "stylua" },
      go = { "gofumpt" },
      python = { "ruff_format", "ruff_organize_imports" }, -- ruff is modern, fast Python formatter
      bash = { "shfmt" },
      sh = { "shfmt" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      -- Common web formats (if needed)
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
    },

    -- Customize formatter behavior
    formatters = {
      stylua = {
        prepend_args = {
          "--indent-type",
          "Spaces",
          "--indent-width",
          "2",
        },
      },
      shfmt = {
        prepend_args = {
          "-i", "2", -- 2 spaces indentation
          "-bn", -- binary ops like && and | may start a line
          "-ci", -- indent switch cases
          "-sr", -- redirect operators will be followed by a space
        },
      },
      prettier = {
        prepend_args = {
          "--tab-width", "2",
          "--use-tabs", "false",
        },
      },
    },

    -- Automatically format on save
    format_on_save = {
      timeout_ms = 1000, -- increased for large files; avoids frequent LSP fallbacks
      lsp_format = "fallback",
    },
  },
}
