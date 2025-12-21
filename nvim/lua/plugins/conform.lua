return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    -- Define formatters by filetype
    formatters_by_ft = {
      lua = { "stylua" },
      -- Add more formatters here as needed:
      -- python = { "black" },
      -- javascript = { "prettier" },
      -- go = { "gofmt" },
    },

    -- Customize stylua to use spaces instead of tabs
    formatters = {
      stylua = {
        prepend_args = {
          "--indent-type",
          "Spaces",
          "--indent-width",
          "2",
        },
      },
    },

    -- Format on save configuration
    format_on_save = {
      timeout_ms = 500, -- timeout for formatting
      lsp_format = "fallback", -- use LSP formatting as fallback if no formatter configured
    },
  },
}
