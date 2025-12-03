return {
	"echasnovski/mini.bufremove",
	version = false,
	config = function()
		local bufremove = require("mini.bufremove")
		bufremove.setup()

		-- Buffer management shortcuts
		vim.keymap.set("n", "<leader>bd", function()
			bufremove.delete(0, false)
		end, { desc = "Buffer delete" })

		vim.keymap.set("n", "<leader>bD", function()
			bufremove.delete(0, true)
		end, { desc = "Buffer delete (force)" })

		vim.keymap.set("n", "<leader>bo", function()
			local current = vim.api.nvim_get_current_buf()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
					bufremove.delete(buf, false)
				end
			end
		end, { desc = "Close other buffers" })

		vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
		vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Prev buffer" })
	end,
}
