return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		current_line_blame = false,
		current_line_blame_opts = {
			delay = 300,
			virt_text_pos = "eol",
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gs.nav_hunk("next")
				end
			end, { desc = "Next Hunk" })

			map("n", "[h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gs.nav_hunk("prev")
				end
			end, { desc = "Prev Hunk" })

			-- Actions
			map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage Hunk" })
			map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
			map("v", "<leader>gs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Stage Hunk" })
			map("v", "<leader>gr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Reset Hunk" })
			-- map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage Buffer" }) -- Disabled as i use lazygit
			-- map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset Buffer" }) -- Disabled as i use lazygit
			map("n", "<leader>gp", gs.preview_hunk_inline, { desc = "Preview Hunk" })
			map("n", "<leader>gi", gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })
			map("n", "<leader>gd", gs.diffthis, { desc = "Diff This" })
			map("n", "<leader>gD", function()
				gs.diffthis("~")
			end, { desc = "Diff This ~" })

			-- Text object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })

			-- Toggle review mode on current buffer
			map("n", "<leader>gR", function()
				gs.toggle_linehl()
				gs.toggle_deleted()
				gs.toggle_word_diff()
				gs.toggle_signs()
			end)
		end,
	},
}
