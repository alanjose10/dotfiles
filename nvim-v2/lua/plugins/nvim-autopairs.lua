return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		enable_check_bracket_line = true, -- Don't add a pair if the next char is a close pair

		-- 1. Intelligent Integration
		-- Use Treesitter to check for a pair.
		check_ts = true,
		ts_config = {
			lua = { "string", "source" }, -- Don't add pairs in lua string treesitter nodes
			javascript = { "template_string" },
			java = false, -- Don't check treesitter on java
		},

		-- 2. Fast Wrap (Optional but cool)
		-- Press <M-e> (Alt+e) to wrap the word after the cursor in brackets.
		-- TODO: this is not currently working.
		fast_wrap = {
			map = "<A-e>",
			chars = { "{", "[", "(", '"', "'" },
			pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
			offset = 0, -- Offset from pattern match
			end_key = "$",
			keys = "qwertyuiopzxcvbnmasdfghjkl",
			check_comma = true,
			highlight = "PmenuSel",
			highlight_grey = "LineNr",
		},
	},
}
