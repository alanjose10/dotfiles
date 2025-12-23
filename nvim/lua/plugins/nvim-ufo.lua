-- nvim-ufo - LSP-powered folding with preview
-- Provides better folding using LSP and Treesitter
return {
	"kevinhwang91/nvim-ufo",
	dependencies = "kevinhwang91/promise-async",
	event = "BufReadPost",
	keys = {
		{ "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
		{ "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
		{
			"zK",
			function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end,
			desc = "Peek fold or hover",
		},
	},
	opts = {
		provider_selector = function(bufnr, filetype, buftype)
			return { "lsp", "treesitter" } -- Use LSP first, fallback to treesitter
		end,
	},
}
