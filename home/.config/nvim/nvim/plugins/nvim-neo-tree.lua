return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	lazy = false, -- neo-tree will lazily load itself
	config = function()
		require("neo-tree").setup({
			close_if_last_window = false,
			popup_border_style = "rounded",
			filesystem = {
				follow_current_file = {
					enabled = true, -- auto-reveal when switching buffers
				},
				use_libuv_file_watcher = true,
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
				},
			},
		})

		----------------------------------------------------
		-- KEYMAPS
		----------------------------------------------------
		-- Toggle Neo-tree (left side)
		vim.keymap.set("n", "<C-n>", ":Neotree left toggle<CR>")

		-- Reveal + expand current file
		vim.keymap.set("n", "<C-e>", ":Neotree reveal<CR>")

		----------------------------------------------------
		-- AUTO OPEN NEO-TREE WHEN OPENING NVIM WITH A DIRECTORY
		----------------------------------------------------
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function(data)
				-- If nvim was started with a directory
				local directory = vim.fn.isdirectory(data.file) == 1
				if directory then
					vim.cmd("Neotree left") -- open neo-tree
				end
			end,
		})

		----------------------------------------------------
		-- AUTO-REVEAL CURRENT FILE WHEN SWITCHING BUFFERS
		----------------------------------------------------
		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function()
				-- Only run if Neo-tree is open
				if vim.fn.exists("#neo-tree#") == 1 then
					pcall(function()
						vim.cmd("Neotree reveal")
					end)
				end
			end,
		})
	end,
}
