-- Create augroups for different concerns
local group = vim.api.nvim_create_augroup("core_autocmds", { clear = true })

-- Highlight on yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight on yank",
})

-- Restore cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  callback = function(event)
    -- Don't apply to gitcommit, gitrebase, or special buffers
    if vim.tbl_contains({ "gitcommit", "gitrebase", "svn" }, vim.bo[event.buf].filetype) then
      return
    end

    -- Get the cursor mark
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(event.buf)

    -- Check that the mark is within the file
    if mark[1] > 0 and mark[1] <= line_count then
      -- Protected call to avoid errors on weird buffers
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Restore cursor position after reopening file",
})

-- Automatically go to terminal mode when terminal opens
vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  callback = function(ev)
    local shell = vim.env.SHELL
    if ev.file:sub(-#shell) == shell then
      vim.cmd("startinsert")
      vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {
        desc = "Exit terminal mode",
        buffer = ev.buf,
      })

      vim.keymap.set("t", "<Esc>q", "<C-\\><C-n>:bd!<CR>", {
        desc = "Exit terminal mode and quit terminal",
        buffer = ev.buf,
      })
    end
  end,
})

-- On toggling the terminal back into view, autmatically set it to insert mode
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = group,
  callback = function(ev)
    local shell = vim.env.SHELL
    if ev.file:sub(-#shell) == shell then
      local ft = require("core.floaterm")
      -- Here we need to also chech if the term buffer was opened is the floating window.
      -- If not, we don't go into insert mode.
      if ft.is_floaterm_win(vim.api.nvim_get_current_win()) then
        vim.cmd("startinsert")
      end
    end
  end,
})

-- Show startup screen when last buffer is closed
vim.api.nvim_create_autocmd("BufDelete", {
  group = group,
  callback = function(event)
    -- Defer to ensure buffer is fully deleted
    vim.schedule(function()
      -- Get list of all buffers
      local bufs = vim.api.nvim_list_bufs()
      local real_buffers = {}

      -- Collect real buffers (exclude special buffers and the one being deleted)
      for _, buf in ipairs(bufs) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and buf ~= event.buf then
          -- Also check if buffer has a name or content
          local name = vim.api.nvim_buf_get_name(buf)
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          local has_content = #lines > 1 or (#lines == 1 and lines[1] ~= "")

          if name ~= "" or has_content then
            table.insert(real_buffers, buf)
          end
        end
      end

      -- If no real buffers left, show intro screen
      if #real_buffers == 0 then
        -- Get the current buffer (the auto-created empty one)
        local current_buf = vim.api.nvim_get_current_buf()

        -- Make sure it's empty and unnamed
        local name = vim.api.nvim_buf_get_name(current_buf)
        if name == "" or name:match("^%s*$") then
          -- Set buffer options to make it act like a scratch buffer
          vim.bo[current_buf].buftype = "nofile"
          vim.bo[current_buf].bufhidden = "wipe"
          vim.bo[current_buf].buflisted = false
          vim.bo[current_buf].swapfile = false

          -- Show the intro screen
          vim.cmd("intro")
        end
      end
    end)
  end,
  desc = "Show intro screen when last buffer is closed",
})
