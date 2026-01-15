return {
	"RRethy/vim-illuminate",
	enabled = false,
	event = "BufReadPost",
	opts = {
		delay = 200, -- Delay in ms before highlighting (feels responsive)
		large_file_cutoff = 10000, -- Disable on huge files to keep Nvim fast
		under_cursor = true,
	},
	config = function(_, opts)
		require("illuminate").configure(opts)

		-- Function to map keys efficiently
		local function map(key, dir, buffer)
			vim.keymap.set("n", key, function()
				require("illuminate")["goto_" .. dir .. "_reference"](false)
			end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
		end

		-- Set keymaps when a buffer is loaded
		map("]]", "next")
		map("[[", "prev")

		-- Also highlight the word visually with a nice underline
		vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
	end,
	keys = {
		{ "]]", desc = "Next Reference" },
		{ "[[", desc = "Prev Reference" },
	},
}
