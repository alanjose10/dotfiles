local M = {}

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

function M.is_floaterm_buf(buf)
	return buf == state.floating.buf
end

local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.85)
	local height = opts.height or math.floor(vim.o.lines * 0.75)

	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local buf
	if opts.buf and vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- scratch, unlisted
	end

	-- keep buffer around when window hides
	vim.bo[buf].bufhidden = "hide"

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	})

	-- window-local opts
	-- vim.wo[win].number = false
	-- vim.wo[win].relativenumber = false
	-- vim.wo[win].signcolumn = "no"
	-- vim.wo[win].wrap = false

	return { buf = buf, win = win }
end

local function ensure_terminal_in_buf(buf)
	-- If this buffer is already a terminal, do nothing (retains state)
	if vim.bo[buf].buftype == "terminal" then
		return
	end

	-- Make this buffer the current one in the current window, then start terminal
	vim.api.nvim_set_current_buf(buf)

	vim.cmd("terminal")
	vim.cmd("startinsert")
end

function M.toggle()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })
		ensure_terminal_in_buf(state.floating.buf)
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

function M.reset()
	-- Close the floating window if open
	if vim.api.nvim_win_is_valid(state.floating.win) then
		vim.api.nvim_win_hide(state.floating.win)
	end

	-- Kill the terminal job (if it exists) and delete the buffer
	if vim.api.nvim_buf_is_valid(state.floating.buf) then
		local ok, job_id = pcall(vim.api.nvim_buf_get_var, state.floating.buf, "terminal_job_id")
		if ok and type(job_id) == "number" then
			pcall(vim.fn.jobstop, job_id)
		end
		pcall(vim.api.nvim_buf_delete, state.floating.buf, { force = true })
	end

	state.floating.buf = -1
	state.floating.win = -1
end

function M.setup_keymaps()
	-- sensible defaults; change if you want
	vim.keymap.set({ "n", "t" }, "<M-t>", M.toggle, { desc = "Toggle floating terminal" })
	vim.keymap.set({ "n", "t" }, "<M-S-t>", M.reset, { desc = "Reset floating terminal" })
end

vim.api.nvim_create_user_command("Floaterminal", function()
	M.toggle()
end, {})
vim.api.nvim_create_user_command("FloaterminalReset", function()
	M.reset()
end, {})

return M
