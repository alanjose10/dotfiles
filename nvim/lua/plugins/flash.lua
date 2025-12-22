return {
  "folke/flash.nvim", -- fast navigation with search labels
  event = "VeryLazy", -- load after startup to improve startup time
  opts = {
    -- Characters used as jump labels (ordered by ease of typing on Colemak-DH home row)
    labels = "arstdhneioqwfpgjluybzxcvkm",

    -- Search behavior configuration
    search = {
      multi_window = true, -- search across all visible windows
      forward = true, -- search in forward direction by default
      wrap = true, -- wrap around to beginning when reaching end
      mode = "exact", -- exact match mode (respects ignorecase/smartcase)
      incremental = false, -- don't show labels while typing
    },
    -- Jump behavior
    jump = {
      jumplist = true, -- save previous location in jumplist (use Ctrl-o to go back)
      pos = "start", -- jump to start of match (options: "start" / "end" / "range")
      history = false, -- don't add searches to search history (/)
      autojump = false, -- require label even for single match (more predictable)
    },

    -- Label appearance and behavior
    label = {
      uppercase = true, -- allow uppercase labels for more jump targets
      rainbow = {
        enabled = false, -- disable rainbow colors for labels (simpler appearance)
      },
    },

    -- Mode-specific configurations
    modes = {
      -- Character mode: Enhanced f/F/t/T motions
      char = {
        enabled = true, -- enable enhanced character motions
        autohide = false, -- keep labels visible
        jump_labels = false, -- don't show labels for f/F/t/T (use default behavior)
        multi_line = true, -- allow f/F/t/T to work across lines
        label = { exclude = "" }, -- no exclusions needed (using arrow keys for navigation)
        keys = { "f", "F", "t", "T", ";", "," }, -- keys that trigger char mode
        search = { wrap = false }, -- don't wrap around for f/F/t/T
        highlight = { backdrop = true }, -- dim other text when searching
      },

      -- Search mode: Integrates with / and ? searches
      search = {
        enabled = true, -- enable flash in regular search (use <c-s> to toggle)
      },

      -- Treesitter mode: Jump to code structures
      treesitter = {
        labels = "arstdhneioqwfpgjluybzxcvkm", -- labels for treesitter targets (Colemak-DH optimized)
        jump = { pos = "range" }, -- jump to entire range of treesitter node
        search = { incremental = false }, -- don't show incremental matches
        label = { before = true, after = true, style = "inline" }, -- show labels before and after
        highlight = {
          backdrop = false, -- don't dim background (keeps code readable)
          matches = false, -- don't highlight matches (less visual noise)
        },
      },
    },
  },

  -- Keymaps for flash navigation
  keys = {
    {
      "s", -- Main flash jump command
      mode = { "n", "x", "o" }, -- works in normal, visual, and operator-pending modes
      function()
        require("flash").jump()
      end,
      desc = "Flash jump", -- Type 2 chars, then use label to jump to any match
    },
    {
      "S", -- Treesitter-aware jumping
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter", -- Jump to functions, classes, parameters, etc.
    },
    {
      "r", -- Remote operation (operator-pending only)
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash", -- Use with operators: dr<label>, yr<label>, cr<label>
    },
    {
      "R", -- Treesitter search in visual/operator mode
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search", -- Search and select treesitter nodes
    },
    {
      "<c-s>", -- Toggle flash during search
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search", -- Press during / or ? to toggle flash labels
    },
  },
}
