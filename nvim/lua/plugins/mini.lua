return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",
  config = function()
    -- mini.surround - Add/delete/replace/find/highlight surrounding text
    -- NOTE: Remapped to 'gs' prefix to avoid clash with flash.nvim 's' keymap
    -- Examples:
    -- gsaiw) - Surround Add Inner Word with )
    -- gsd'   - Surround Delete '
    -- gsr)"  - Surround Replace ) with "
    -- gsf)   - Surround Find )
    -- gsh)   - Surround Highlight )
    require("mini.surround").setup({
      -- Add custom surroundings to be used on top of builtin ones.
      custom_surroundings = nil,
      -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
      highlight_duration = 500,
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
        suffix_last = "l", -- Suffix to search with "prev" method
        suffix_next = "n", -- Suffix to search with "next" method
      },
      -- Number of lines within which surrounding is searched
      n_lines = 20,
      -- Whether to respect selection type:
      -- - Place surroundings on separate lines in linewise mode.
      -- - Place surroundings on each line in blockwise mode.
      respect_selection_type = false,
      -- How to search for surrounding (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'prev', 'nearest'.
      search_method = "cover",
      -- Whether to disable showing non-error feedback
      silent = false,
    })

    -- Other useful mini modules (uncomment to enable):
    -- require("mini.ai").setup() -- Better text objects
    -- require("mini.move").setup() -- Move lines/selections
    -- require("mini.bracketed").setup() -- Navigate brackets/diagnostics
  end,
}
