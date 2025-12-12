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
			-- Auto-install language servers we rely on
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
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"b0o/schemastore.nvim",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local autoformat_group = vim.api.nvim_create_augroup("LspAutoFormat", { clear = true })

			local function common_on_attach(client, bufnr)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				-- Core LSP UX bindings
				map("n", "K", vim.lsp.buf.hover, "Hover")
				map("n", "<leader>cd", vim.lsp.buf.definition, "Go to definition")
				map("n", "<leader>cD", vim.lsp.buf.declaration, "Go to declaration")
				map("n", "<leader>cr", vim.lsp.buf.references, "Go to references")
				map("n", "<leader>ci", vim.lsp.buf.implementation, "Go to implementation")
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions")
				map("n", "<leader>cs", vim.lsp.buf.signature_help, "Signature help")
				map("n", "<leader>cf", function()
					vim.lsp.buf.format({ async = false, bufnr = bufnr })
				end, "Format buffer")
			end

			local servers = {
				lua_ls = {
					-- Avoid formatting conflicts and make Lua aware of Neovim runtime
					on_init = function(client)
						if client.workspace_folders then
							local path = client.workspace_folders[1].name
							if
								path ~= vim.fn.stdpath("config")
								and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
							then
								return
							end
						end

						client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
							runtime = {
								version = "LuaJIT",
								path = {
									"lua/?.lua",
									"lua/?/init.lua",
								},
							},
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME,
								},
							},
						})
					end,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
					on_attach = function(client, bufnr)
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
						common_on_attach(client, bufnr)
					end,
				},
			}

			for server, config in pairs(servers) do
				config.capabilities = capabilities
				config.on_attach = config.on_attach or common_on_attach
				vim.lsp.config(server, config)
			end

			-- Enable all configured servers
			vim.lsp.enable(vim.tbl_keys(servers))

			-- Global format-on-save (prefers null-ls when available)
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = autoformat_group,
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
				automatic_installation = true,
			})
		end,
	},
}
