-- indent-blankline.nvim - Show indentation guides
-- Displays vertical lines at each indentation level
--
-- Features:
--   - Shows indent guides for better code readability
--   - Highlights current scope (current indentation block)
--   - Works with treesitter for smarter scope detection
--   - Configurable colors that work with your colorscheme

return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  main = "ibl",
  opts = {
    -- Indentation guide characters
    indent = {
      char = "│", -- character for indent guides
      tab_char = "│", -- character for tab indents
    },

    -- Scope highlighting (current indentation block)
    scope = {
      enabled = true, -- highlight current scope
      show_start = true, -- underline at scope start
      show_end = false, -- don't underline at scope end
      injected_languages = true, -- highlight injected languages (e.g., JS in HTML)
      highlight = { "Function", "Label" }, -- colors to use
      priority = 500,
    },

    -- Exclude certain filetypes and buffer types
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      buftypes = {
        "terminal",
        "nofile",
        "quickfix",
        "prompt",
      },
    },
  },
}
