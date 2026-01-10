return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    local ns = require("neoscroll")

    ns.setup({
      easing_function = "quadratic", -- Controls "smoothness" of the scroll animation
      hide_cursor = true, -- Hide cursor while scrolling for smoother visuals
    })

    local mappings = {
      -- Half-page down, then center cursor
      ["<C-d>"] = function()
        ns.scroll(vim.wo.scroll, { move_cursor = true, duration = 300 })
        vim.cmd("normal! zz")
      end,

      -- Half-page up, then center cursor
      ["<C-u>"] = function()
        ns.scroll(-vim.wo.scroll, { move_cursor = true, duration = 300 })
        vim.cmd("normal! zz")
      end,
    }

    for key, func in pairs(mappings) do
      vim.keymap.set("n", key, func, { silent = true, desc = "Smooth scroll: " .. key })
    end
  end,
}
