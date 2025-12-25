return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = { "Neotree" }, -- lazy load on command
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<C-n>", ":Neotree left toggle<CR>", desc = "Toggle file tree" },
	},
	config = function()
		require("neo-tree").setup({
			default_component_configs = {
				-- Do not show size, type, last modified, etc. Keep the window clean.
				file_size = {
					enabled = false,
				},
				type = {
					enabled = false,
				},
				last_modified = {
					enabled = false,
				},
				created = {
					enabled = false,
				},
			},
			close_if_last_window = true,
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

				-- Telescope: find_files in selected path
				telescope_find_in_dir = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()

					-- If it's a file, search in its parent directory
					if node.type ~= "directory" then
						path = vim.fn.fnamemodify(path, ":h")
					end

					-- Check if telescope is available
					local ok, telescope = pcall(require, "telescope.builtin")
					if not ok then
						vim.notify("Telescope is not available", vim.log.levels.ERROR)
						return
					end

					telescope.find_files({
						cwd = path,
						hidden = true, -- include hidden files
						no_ignore = false, -- respect .gitignore (false = do respect)
					})
				end,

				-- Telescope: live_grep in selected path
				telescope_grep_in_dir = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()

					if node.type ~= "directory" then
						path = vim.fn.fnamemodify(path, ":h")
					end

					-- Check if telescope is available
					local ok, telescope = pcall(require, "telescope.builtin")
					if not ok then
						vim.notify("Telescope is not available", vim.log.levels.ERROR)
						return
					end

					telescope.live_grep({
						cwd = path,
						additional_args = function()
							return { "--hidden" } -- include hidden files
						end,
					})
				end,
				-- Popup to get file name/path
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
			-- NEO-TREE WINDOW MAPPINGS
			window = {
				mappings = {
					Y = "copy_selector",
					["<leader>ff"] = "telescope_find_in_dir",
					["<leader>fg"] = "telescope_grep_in_dir",
				},
			},
		})

		-- AUTO OPEN NEO-TREE WHEN OPENING NVIM WITH A DIRECTORY
		local neotree_group = vim.api.nvim_create_augroup("neotree_autoopen", { clear = true })
		vim.api.nvim_create_autocmd("VimEnter", {
			group = neotree_group,
			callback = function(data)
				-- Only run if nvim was started with a directory argument
				local directory = vim.fn.isdirectory(data.file) == 1
				if directory then
					-- Schedule to avoid conflicts with other startup plugins
					vim.schedule(function()
						vim.cmd("Neotree left")
					end)
				end
			end,
			desc = "Auto-open neo-tree when opening a directory",
		})

		-- Note: Auto-reveal is handled by follow_current_file.enabled = true in config
		-- No need for additional BufEnter autocmd (causes performance issues)
	end,
}
