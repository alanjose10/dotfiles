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
		config = function()
			-- Add blink.cmp capabilities to all servers
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			-- Enable servers (configs loaded from lsp/ directory)
			vim.lsp.enable({ "lua_ls", "gopls" })

			-- Keymaps on attach (navigation handled by snacks.nvim pickers)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
					end
					-- Hover & Actions
					map("n", "K", vim.lsp.buf.hover, "Hover")
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("n", "<leader>cn", vim.lsp.buf.rename, "Rename")
					-- Diagnostics
					map("n", "<leader>ce", vim.diagnostic.open_float, "Show diagnostic")
					map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
					map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
				end,
			})
		end,
	},
}
