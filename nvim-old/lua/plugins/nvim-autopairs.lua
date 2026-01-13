-- Auto-pairing of brackets, quotes, etc.
-- Properly jumps over closing characters instead of inserting duplicates
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = true,
  opts = {},
}
