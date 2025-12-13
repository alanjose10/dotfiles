return {
	{
		"mason-org/mason.nvim",
		opts = {},
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
				opts = {
					library = {
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
			}

			local common_on_attach = function(_, _)
				-- common on attach function
			end

			for server, config in pairs(servers) do
				config.capabilities = capabilities

				-- if on_attach is not defined, use the common on attach function
				config.on_attach = config.on_attach or common_on_attach

				vim.lsp.config(server, config)
			end

			-- Enable all configured servers
			vim.lsp.enable(vim.tbl_keys(servers))

			-- Global format-on-save (prefers null-ls when available)
			vim.api.nvim_create_autocmd("BufWritePre", {
				-- group = autoformat_group,
				callback = function(ev)
					local bufnr = ev.buf
					local formatters = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/formatting" })
					if #formatters == 0 then
						return
					end
					local has_null_ls = false
					for _, client in ipairs(formatters) do
						if client.name == "null-ls" then
							has_null_ls = true
							break
						end
					end
					vim.lsp.buf.format({
						bufnr = bufnr,
						timeout_ms = 3000,
						filter = function(client)
							if has_null_ls then
								return client.name == "null-ls"
							end
							return true
						end,
					})
				end,
			})

			-- Popup diagnostic
			vim.o.updatetime = 250
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false })
				end,
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			-- null-ls provides formatting/linting; actual format-on-save is handled by the global autocmd above
			null_ls.setup({
				sources = {
					-- Lua
					null_ls.builtins.formatting.stylua,
				},
			})

			vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "Format" })
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"nvimtools/none-ls.nvim",
			"mason-org/mason.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"stylua",
				},
				automatic_installation = true,
			})
		end,
	},
}
