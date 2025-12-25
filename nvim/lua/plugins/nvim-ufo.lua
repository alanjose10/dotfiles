-- nvim-ufo - LSP-powered folding with preview
-- Provides better folding using LSP and Treesitter
--
-- Navigation between folds:
--   Use native vim commands (no custom keybindings to avoid conflicts):
--   - zj: Move to next fold
--   - zk: Move to previous fold
--   - za: Toggle fold at cursor (also mapped to <leader>z for convenience)
--
return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "BufReadPost",
  keys = {
    -- Global fold operations
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
      desc = "Open all folds",
    },
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
      desc = "Close all folds",
    },

    -- Toggle fold at cursor (convenient alternative to vim's native za)
    { "<leader>z", "za", desc = "Toggle fold at cursor" },
  },
  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      -- Use LSP for folding when available, fallback to indent-based folding
      -- Indent is more reliable than treesitter and prevents UfoFallbackException
      return { "lsp", "indent" }
    end,
  },
}
