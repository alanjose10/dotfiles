return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = {
			enabled = true, -- Disable heavy features on large files
			notify = true,
			size = 1024 * 1024, -- 1MB
			line_length = 10000,
		},
		explorer = {
			enabled = true,
			replace_netrw = true, -- Replace netrw with the snacks explorer
			trash = true, -- Use the system trash when deleting files
			-- your explorer configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		picker = {
			enabled = true,
			win = {
				input = {
					keys = {
						["<Tab>"] = "focus_preview",
						["<Esc>"] = "close",
					},
				},
				preview = {
					keys = {
						["<Tab>"] = "focus_input",
					},
				},
			},
			sources = {
				explorer = {
					layout = { layout = { position = "left" } },
					-- Default to showing hidden files
					hidden = true,
					-- Don't close the explorer when I open a file (persistent sidebar)
					auto_close = true,
					-- Jump to the file in the explorer when I change buffers
					follow_file = true,
					-- your explorer picker configuration comes here
					-- or leave it empty to use the default settings
				},
			},
		},
		lazygit = {},
		indent = {
			enabled = true,
			animate = { enabled = false },
		},
		scroll = {
			enabled = true,
			animate = {
				duration = { step = 20, total = 500 },
				easing = "linear",
			},
		},
		-- disable other stuff
		dashboard = { enabled = false },
		notifier = { enabled = false },
		input = { enabled = false },
		scope = { enabled = false },
		scratch = { enabled = false },
	},
	keys = {
		{
			"<leader><space>",
			function()
				Snacks.picker.smart({
					hidden = true,
					layout = "vscode",
					ignored = false, -- Respect .gitignore
					exclude = { ".git", "node_modules", "plz-out", ".plz-cache" },
				})
			end,
			desc = "Smart Find Files",
		},

		{
			"<leader>ff",
			function()
				Snacks.picker.files({
					hidden = true,
					-- layout = "vscode",
					ignored = false, -- Respect .gitignore
					exclude = { ".git", "node_modules", "plz-out", ".plz-cache" },
				})
			end,
			desc = "Find Files",
		},

		{
			"<leader>/",
			function()
				Snacks.picker.grep({
					ignored = false, -- Respect .gitignore
					exclude = { ".git", "node_modules", "plz-out", ".plz-cache" },
				})
			end,
			desc = "Grep Project",
		},

		{
			"<leader>,",
			-- function()
			-- 	Snacks.picker.buffers()
			-- end,
			function()
				Snacks.picker.buffers({
					on_show = function()
						vim.cmd.stopinsert()
					end,
					finder = "buffers",
					format = "buffer",
					hidden = false,
					unloaded = true,
					current = true,
					sort_lastused = true,
					win = {
						input = {
							keys = {
								["d"] = "bufdelete",
							},
						},
						list = { keys = { ["d"] = "bufdelete" } },
					},
					-- In case you want to override the layout for this keymap
					-- layout = "ivy",
				})
			end,
			desc = "Buffers",
		},

		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "Snacks File Explorer",
		},

		{
			"<leader>fr",
			function()
				Snacks.picker.recent({ filter = { cwd = true } })
			end,
			desc = "Recent Files (CDW)",
		},

		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>fp",
			function()
				Snacks.picker.projects({
					confirm = function(picker, item)
						picker:close()
						if item.file then
							vim.fn.chdir(item.file) -- Change directory
						end
					end,
				})
			end,
			desc = "Projects",
		},
		{
			"<leader>fz",
			function()
				Snacks.picker.zoxide({
					confirm = function(picker, item)
						picker:close()
						if item.file then
							vim.fn.chdir(item.file) -- Change directory
						end
					end,
				})
			end,
			desc = "Zoxide",
		},

		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Grep Word Under Cursor",
			mode = { "n", "x" },
		},

		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Search Buffer Lines",
		},

		-- Help: Search help tags (crucial for learning)
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>sC",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>sr",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume Last Picker",
		},

		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Search Registers",
		},

		-- UI
		{
			"<leader>uC",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
		},

		-- GIT
		-- Opens Lazygit in a floating window
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git Log Line",
		},
		-- Shows every commit that touched the current file.
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log (File)",
		},

		-- Git blame line in pop-up
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame Line",
		},

		{
			"<leader>fq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix List",
		},
		-- List marks
		-- add marks: m followed by a char
		-- jump to mark: '<char> followed
		-- jump to exact mark col: `<char> followed by
		{
			"<leader>`",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},

		-- Replaces the native 'z=' with a nice picker
		{
			"<leader>z",
			function()
				Snacks.picker.spelling()
			end,
			desc = "Fix Spelling",
		},

		-- -- LSP Navigation (using snacks pickers for preview + filtering)
		-- {
		-- 	"gd",
		-- 	function()
		-- 		Snacks.picker.lsp_definitions()
		-- 	end,
		-- 	desc = "Go to definition",
		-- },
		-- {
		-- 	"gr",
		-- 	function()
		-- 		Snacks.picker.lsp_references()
		-- 	end,
		-- 	desc = "Find references",
		-- },
		-- {
		-- 	"gI",
		-- 	function()
		-- 		Snacks.picker.lsp_implementations()
		-- 	end,
		-- 	desc = "Go to implementation",
		-- },
		-- {
		-- 	"gy",
		-- 	function()
		-- 		Snacks.picker.lsp_type_definitions()
		-- 	end,
		-- 	desc = "Go to type definition",
		-- },
		-- {
		-- 	"<leader>ss",
		-- 	function()
		-- 		Snacks.picker.lsp_symbols()
		-- 	end,
		-- 	desc = "LSP Symbols",
		-- },
	},
}
