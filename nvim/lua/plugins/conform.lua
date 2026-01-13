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
		},
		-- Auto-format on save
		format_on_save = {
			timeout_ms = 1000,
			lsp_fallback = true, -- Use LSP formatting if no formatter is defined
		},
	},
}
