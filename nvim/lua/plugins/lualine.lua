return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "auto", -- Automatically picks colors based on your theme
      globalstatus = true, -- ONE statusline for all splits (cleaner look)
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "", right = "" }, -- Minimal look (no arrows)
    },
    sections = {
      -- LEFT SIDE: Mode, Branch, Diff
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        {
          "filename",
          path = 1,
        },
      },
      -- RIGHT SIDE: Diagnostics, Snacks Info, Filetype, Location
      lualine_x = {
        "lsp_status",
      },
      lualine_y = { "encoding", "filetype", "filesize" },
      lualine_z = { "location", "progress" },
    },
    always_show_tabline = true,
  },
}
