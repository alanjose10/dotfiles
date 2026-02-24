return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	ft = { "markdown" },
	opts = {
		heading = {
			sign = false, -- don't clutter the sign column with heading level icons
			width = "full", -- extend heading background across the full window width
		},
		code = {
			style = "full", -- render language icon, background, and borders on code blocks
			width = "block", -- only extend background to the width of the code, not full window
			border = "thin", -- thin border lines above/below code blocks
		},
		bullet = {
			-- use cleaner unicode bullets instead of raw -, *, +
			icons = { "●", "○", "◆", "◇" },
		},
		checkbox = {
			-- nicer checkbox icons for task lists
			unchecked = { icon = "󰄱 " },
			checked = { icon = "󰱒 " },
		},
		pipe_table = {
			style = "full", -- render table borders and cell backgrounds
		},
	},
}
