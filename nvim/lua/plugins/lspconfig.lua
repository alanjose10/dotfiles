return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
		},
		opts = {
			ensure_installed = {
				"stylua",
				"goimports",
				"gofumpt",
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
					"gopls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			{ "folke/lazydev.nvim", ft = "lua", opts = {} },
		},
		opts = {
			inlay_hints = {
				enabled = true,
			},
		},
		config = function()
			-- Add blink.cmp capabilities to all servers
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			-- Enable servers (configs loaded from lsp/ directory)
			vim.lsp.enable({ "lua_ls", "gopls" })

			-- Keymaps on attach (navigation handled by snacks.nvim pickers)
			vim.api.nvim_create_autocmd("LspAttach", {

				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					local function map(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = args.buf, desc = desc })
					end

					-- Snacks
					map("gd", function()
						Snacks.picker.lsp_definitions()
					end, "Go to Definition")

					map("grr", function()
						Snacks.picker.lsp_references()
					end, "Go to References")

					map("grI", function()
						Snacks.picker.lsp_implementations()
					end, "Go to Implementation")

					map("gy", function()
						Snacks.picker.lsp_type_definitions()
					end, "Go to Type Definition")

					map("gri", function()
						Snacks.picker.lsp_incoming_calls()
					end, "LSP Incoming Calls")

					map("gro", function()
						Snacks.picker.lsp_outgoing_calls()
					end, "LSP Outgoing Calls")

					map("<leader>ss", function()
						Snacks.picker.lsp_symbols()
					end, "LSP Symbols")

					map("<leader>sd", function()
						Snacks.picker.diagnostics_buffer()
					end, "List Diagnostics")

					map("K", vim.lsp.buf.hover, "Hover")
					map("<leader>cd", vim.diagnostic.open_float, "Show diagnostic")
					map("]d", vim.diagnostic.goto_next, "Next diagnostic")
					map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")

					if client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
						map("<leader>uh", function()
							vim.lsp.inlay_hint.enable(
								not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }),
								{ bufnr = args.buf }
							)
						end, "Toggle Inlay Hints")
					end

					-- Skip document highlight for large files (performance)
					local max_lines = 5000
					if
						client.server_capabilities.documentHighlightProvider
						and vim.api.nvim_buf_line_count(args.buf) <= max_lines
					then
						local highlight_grp = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = args.buf,
							group = highlight_grp,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = args.buf,
							group = highlight_grp,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})
		end,
	},
}
