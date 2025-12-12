-- Use different flavour for home and work
local function get_catppuccin_flavour()
	local env = vim.env.DOTFILE_ENV
	if env == "home" then
		return "frappe"
	end
	return "macchiato"
end

return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = get_catppuccin_flavour(),
			term_colors = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				mason = true,
				neotree = true,
				telescope = true,
				treesitter = true,
				which_key = true,
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
