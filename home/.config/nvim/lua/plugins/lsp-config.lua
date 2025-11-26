return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Capabilities for nvim-cmp
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-----------------------------------------------------------------------
			-- Global defaults for ALL LSP servers
			-----------------------------------------------------------------------
			vim.lsp.config("*", {
				capabilities = capabilities,
				root_markers = {
					".git",
				},
			})

			vim.lsp.config("lua_ls", {
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
							-- Tell the language server which version of Lua you're using (most
							-- likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
							-- Tell the language server how to find Lua modules same way as Neovim
							-- (see `:h lua-module-load`)
							path = {
								"lua/?.lua",
								"lua/?/init.lua",
							},
						},
						-- Make the server aware of Neovim runtime files
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
				on_attach = function(client)
					-- Disable lua_ls formatting
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
			})

			-----------------------------------------------------------------------
			-- gopls: disable formatting, use gofumpt instead
			-----------------------------------------------------------------------
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						gofumpt = true,
					},
				},
				on_attach = function(client)
					-- Turn OFF gopls formatting so gofumpt (none-ls) is used instead
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
			})

			-----------------------------------------------------------------------
			-- Enable your LSP servers
			-----------------------------------------------------------------------
			vim.lsp.enable({
				"lua_ls",
				"gopls",
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					local buf = ev.buf

					-----------------------
					-- LSP Keymaps
					-----------------------
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

					-----------------------
					-- Format on save
					-----------------------
					if client and client.supports_method("textDocument/formatting") then
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = buf,
							callback = function()
								vim.lsp.buf.format({
									async = false,
									timeout = 3000,
								})
							end,
						})
					end
				end,
			})

			-- Auto format go imports on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					local params = vim.lsp.util.make_range_params()
					params.context = { only = { "source.organizeImports" } }
					-- buf_request_sync defaults to a 1000ms timeout. Depending on your
					-- machine and codebase, you may want longer. Add an additional
					-- argument after params if you find that you have to write the file
					-- twice for changes to be saved.
					-- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
					local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
					for cid, res in pairs(result or {}) do
						for _, r in pairs(res.result or {}) do
							if r.edit then
								local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
								vim.lsp.util.apply_workspace_edit(r.edit, enc)
							end
						end
					end
					vim.lsp.buf.format({ async = false })
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
			null_ls.setup({
				sources = {
					-- Lua
					null_ls.builtins.formatting.stylua,

					-- Golang
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.diagnostics.golangci_lint,

					-- Python
					null_ls.builtins.formatting.black,
					-- TODO: isort is not letting black run the formatting
					-- null_ls.builtins.formatting.isort,
				},
			})

			vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "Format" })
		end,
	},
}
