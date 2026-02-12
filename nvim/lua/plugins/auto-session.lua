return {
	"rmagatti/auto-session",
	lazy = false,
	dependencies = {
		"folke/snacks.nvim",
	},
	opts = {
		auto_save = true,

		auto_restore = false,

		git_use_branch = true,
		git_use_branch_name = true,
		git_auto_restore_on_branch_change = true,

		auto_delete_empty_sessions = true,
		purge_after_minutes = 14400,

		-- Directories to ignore
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },

		session_lens = {
			picker = "snacks",

			picker_opts = {
				layout = {
					preset = "dropdown",
				},
			},

			mappings = {
				-- Delete the highlighted session from the picker
				delete_session = { "i", "<C-d>" },
			},
		},
	},
	keys = {
		-- Keymaps for session management
		{ "<leader>fs", "<cmd>AutoSession search<CR>", desc = "Find/Pick Sessions (Snacks)" },
		{ "<leader>SS", "<cmd>AutoSession save<CR>", desc = "Save Session" },
		-- { "<leader>sr", "<cmd>SessionRestore<CR>", desc = "Restore Session for cwd" },
		-- { "<leader>sd", "<cmd>SessionDelete<CR>", desc = "Delete Session for cwd" },
	},
}
