return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
    },
    opts = {
      -- Auto-install formatters and linters
      ensure_installed = {
        -- Formatters
        "stylua", -- Lua
        "gofumpt", -- Go
        "ruff", -- Python (formatter + linter)
        "shfmt", -- Bash/shell
        "prettier", -- JSON, YAML, Markdown, JS, TS, CSS, HTML
      },
      auto_update = false,
      run_on_start = true,
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "jsonls",
          "yamlls",
          "gopls",
          "pyright",
          "bashls",
          "marksman",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/schemastore.nvim",
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {

        lua_ls = {
          on_attach = function(client, _)
            -- disable formatting for lua_ls
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },

        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },

        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },

        gopls = {
          settings = {
            gopls = {
              -- Exclude build output directories (critical for large monorepos)
              directoryFilters = {
                "-plz-out",
                "-bazel-bin",
                "-bazel-out",
                "-bazel-testlogs",
                "-node_modules",
                "-.git",
              },
              analyses = {
                unusedparams = true,
              },
              gofumpt = true,
            },
          },
        },

        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },

        bashls = {},

        marksman = {},
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config(server, config)
      end

      -- Enable all configured servers
      vim.lsp.enable(vim.tbl_keys(servers))

      -- Setup LSP keymaps on attach (using LspAttach autocmd for new API)
      -- Note: Navigation keymaps (gd, gr, gI, gy, gD) are handled by snacks.picker
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
        callback = function(event)
          local bufnr = event.buf
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
          end

          -- Code actions
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions")
          map("n", "<leader>cn", vim.lsp.buf.rename, "Rename symbol")

          -- Documentation
          map("n", "K", vim.lsp.buf.hover, "Hover documentation")
          map("n", "<leader>cs", vim.lsp.buf.signature_help, "Signature help")

          -- Diagnostics navigation
          map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
          map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
          map("n", "<leader>ce", vim.diagnostic.open_float, "Show diagnostic")
        end,
      })

      -- Note: Removed CursorHold autocmd for diagnostics to reduce memory usage
      -- Use <leader>ce to manually show diagnostics when needed
    end,
  },
}
