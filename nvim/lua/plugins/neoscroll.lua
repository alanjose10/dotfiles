return {
	"karb94/neoscroll.nvim",
	event = "VeryLazy",
	config = function()
		require("neoscroll").setup({
			easing_function = "quadratic", -- Controls "smoothness" of the scroll animation
			hide_cursor = true, -- Hide cursor while scrolling for smoother visuals
		})

		local ns = require("neoscroll")

		local mappings = {
			-- scroll window *up* one line WITHOUT moving cursor
			["<C-u>"] = function()
				ns.scroll(-0.1, { move_cursor = false, duration = 100 })
			end,

			-- scroll window *down* one line WITHOUT moving cursor
			["<C-e>"] = function()
				ns.scroll(0.1, { move_cursor = false, duration = 100 })
			end,
		}

		-- APPLY KEYMAPS
		for key, func in pairs(mappings) do
			vim.keymap.set("n", key, func, { silent = true, desc = "Smooth scroll: " .. key })
		end
	end,
}
