return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize this keymap to your liking
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format Buffer",
		},
	},
	opts = {
		-- Define which formatter to use for each filetype
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports", "gofumpt" }, -- imports first, then gofumpt
			toml = { "taplo" },
			markdown = { "prettier" },
		},
		-- Auto-format on save (longer timeout for large monorepos)
		format_on_save = {
			timeout_ms = 5000,
			lsp_fallback = true, -- Use LSP formatting if no formatter is defined
		},
	},
}
