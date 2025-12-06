return {
	"karb94/neoscroll.nvim",
	event = "VeryLazy",
	config = function()
		require("neoscroll").setup({
			easing_function = "quadratic", -- Controls "smoothness" of the scroll animation
			hide_cursor = true, -- Hide cursor while scrolling for smoother visuals
		})

		local ns = require("neoscroll")

		---------------------------------------------------------------------------
		-- CUSTOM SMOOTH SCROLL MAPPINGS
		---------------------------------------------------------------------------
		-- These override the standard motions to smoothly animate instead of "jump".
		-- The duration (in ms) controls how fast the scroll animation is.

		local mappings = {
			-- Smooth <C-u>  (scroll up half page)
			-- Default behavior: instant jump up half page
			-- Smooth behavior: glide upward 15–20 lines
			["<C-j>"] = function()
				ns.ctrl_u({ duration = 150 })
			end,

			-- Smooth <C-d> (scroll down half page)
			["<C-;>"] = function()
				ns.ctrl_d({ duration = 150 })
			end,

			-- Smooth <C-b> (scroll back full page)
			-- Usually a big "jump", now animated
			["<C-l>"] = function()
				ns.ctrl_b({ duration = 200 })
			end,

			-- Smooth <C-f> (scroll forward full page)
			["<C-y>"] = function()
				ns.ctrl_f({ duration = 200 })
			end,

			-- Smooth <C-y> (scroll window *up* one line WITHOUT moving cursor)
			-- Useful for reading code while keeping cursor in place
			["<C-u>"] = function()
				ns.scroll(-0.1, { move_cursor = false, duration = 100 })
			end,

			-- Smooth <C-e> (scroll window *down* one line WITHOUT moving cursor)
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
