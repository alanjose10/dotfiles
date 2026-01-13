return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    -- optimize for Colemak DH
  labels = "arstneiodhplfuwyqjkmzxcvb",
},
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },

    -- 2. Treesitter Mode: Highlights logical code blocks (functions, loops).
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  },
}
