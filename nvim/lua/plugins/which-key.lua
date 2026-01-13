return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix", -- "classic", "modern", or "helix" (vertical list)
		-- Delay before the menu opens (in milliseconds)
		delay = function(ctx)
			return ctx.plugin and 0 or 400
		end,
		spec = {
			-- You can manually group keymaps here if you want nice labels
			{ "<leader>f", group = "file/find" },
			{ "<leader>g", group = "git" },
			{ "<leader>c", group = "code" },
			{ "<leader>s", group = "search" },
			{ "<leader>u", group = "ui/toggle" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Keymaps (Which Key)",
		},
	},
}
