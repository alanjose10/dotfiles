return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = { "Neotree" },
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
			commands = {
				copy_selector = function(state)
					local node = state.tree:get_node()
					local filepath = node:get_id()
					local filename = node.name
					local modify = vim.fn.fnamemodify

					local vals = {
						["BASENAME"] = modify(filename, ":r"),
						["EXTENSION"] = modify(filename, ":e"),
						["FILENAME"] = filename,
						["PATH (CWD)"] = modify(filepath, ":."),
						["PATH (HOME)"] = modify(filepath, ":~"),
						["PATH"] = filepath,
						["URI"] = vim.uri_from_fname(filepath),
					}

					local options = vim.tbl_filter(function(val)
						return vals[val] ~= ""
					end, vim.tbl_keys(vals))
					if vim.tbl_isempty(options) then
						vim.notify("No values to copy", vim.log.levels.WARN)
						return
					end
					table.sort(options)
					vim.ui.select(options, {
						prompt = "Choose to copy to clipboard:",
						format_item = function(item)
							return ("%s: %s"):format(item, vals[item])
						end,
					}, function(choice)
						local result = vals[choice]
						if result then
							vim.notify(("Copied: `%s`"):format(result))
							vim.fn.setreg("+", result)
						end
					end)
				end,
			},
			window = {
				mappings = {
					Y = "copy_selector",
				},
			},
		})

		----------------------------------------------------
		-- KEYMAPS
		----------------------------------------------------
		-- Toggle Neo-tree (left side)
		vim.keymap.set("n", "<C-n>", ":Neotree left toggle<CR>", { desc = "Toggle file tree" })

		-- Reveal + expand current file
		vim.keymap.set("n", "<C-e>", ":Neotree reveal<CR>", { desc = "Reveal file in tree" })

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
