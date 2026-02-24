return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("diffview").setup({
			enhanced_diff_hl = true,
			view = {
				default = {
					layout = "diff2_horizontal",
				},
			},
		})

		-- Custom Keymaps for reviewing AI changes
		vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Open DiffView" })
		vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewClose<CR>", { desc = "Close DiffView" })
	end,
}
