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
			}

			for server, config in pairs(servers) do
				config.capabilities = capabilities
				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end

			-- Enable all configured servers

			-- Setup LSP keymaps on attach (using LspAttach autocmd for new API)
			-- Note: Navigation keymaps (gd, gr, gI, gy, gD) are handled by snacks.picker
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
				callback = function(event)
					local bufnr = event.buf
					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
					end

					-- Navigation
					map("n", "gd", vim.lsp.buf.definition, "Go to definition")
					map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
					map("n", "gI", vim.lsp.buf.implementation, "Go to implementation")
					map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
					map("n", "gr", vim.lsp.buf.references, "Find references")

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
