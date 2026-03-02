return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "auto", -- Automatically picks colors based on your theme
			globalstatus = true, -- ONE statusline for all splits (cleaner look)
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "", right = "" }, -- Minimal look (no arrows)
		},
		sections = {
			-- LEFT SIDE
			lualine_a = {
				{
					"tabs",
					mode = 0, -- 0: just number, 1: just name, 2: number and name
					path = 0, -- 0: filename, 1: relative path, 2: absolute path

					-- Optional: customize colors
					tabs_color = {
						active = "lualine_a_normal",
						inactive = "lualine_b_normal",
					},
				},
				"mode",
			},
			lualine_b = {
				{
					"branch",
					fmt = function(str)
						if str == "" or str == nil then
							return str
						end
						-- Change 15 to whatever max length you want
						if #str > 15 then
							return string.sub(str, 1, 15) .. "..."
						end
						return str
					end,
				},
				"diff",
				"diagnostics",
			},
			lualine_c = {
				{
					"filename",
					path = 1,
				},
			},
			-- RIGHT SIDE
			lualine_x = {
				"lsp_status",
				{
					function()
						local status = require("sidekick.status").cli()
						return " " .. (#status > 1 and #status or "")
					end,
					cond = function()
						return #require("sidekick.status").cli() > 0
					end,
					color = function()
						return "Special"
					end,
				},
			},
			lualine_y = {
				"encoding",
				"filetype",
				"filesize",
				{
					"aerial",
					fmt = function(str)
						return str
					end,
				},
			},
			lualine_z = { "location", "progress" },
		},
		always_show_tabline = true,
	},
}
