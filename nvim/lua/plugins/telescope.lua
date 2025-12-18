return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = { "Telescope", "TelescopeFindFiles" },
		tag = "v0.1.9",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			---@type telescope.config.Config
			local opts = {
				pickers = {
					find_files = {
						theme = "ivy",
					},
					git_files = {
						theme = "ivy",
					},
					registers = {
						theme = "ivy",
					},
				},
				extensions = {
					fzf = {},
				},
				defaults = {
					layout_strategy = "horizontal",
					layout_config = {
						prompt_position = "top",
						horizontal = {
							preview_width = 0.55,
						},
					},
					sorting_strategy = "ascending",
					path_display = { "smart" },
					file_ignore_patterns = {
						".git/",
						"bazel%-bin",
						"bazel%-out",
						"bazel%-testlogs",
						"plz%-out",
						"node_modules",
						"%.cache",
					},
					dynamic_preview_title = true,
				},
			}
			telescope.setup(opts)

			telescope.load_extension("fzf")

			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope explore help" })

			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope search keymaps" })

			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({ hidden = true, follow = true })
			end, { desc = "Telescope find files" })

			vim.keymap.set("n", "<leader>FF", builtin.git_files, { desc = "Telescope find files tracked by git" })

			vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Grep string under cursor" })

			vim.keymap.set("n", "<leader><BS>", function()
				builtin.oldfiles({ only_cwd = true })
			end, { desc = "Recent files (cwd)" })

			vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "Telescope buffers" })

			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Workspace diagnostics" })

			vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume last picker" })

			vim.keymap.set("n", "<leader>fsb", builtin.current_buffer_fuzzy_find, { desc = "Search in buffer" })

			vim.keymap.set("n", "<leader>tr", builtin.registers, { desc = "Telescope registers" })

			-- Setup multigrep
			require("plugins.telescope.multigrep").setup()

			vim.keymap.set("n", "<leader>fp", function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.stdpath("data") .. "/lazy",
					prompt_title = "Plugin Source",
				})
			end, { desc = "Find plugin source" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
