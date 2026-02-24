return {
	"folke/sidekick.nvim",
	-- snacks.nvim is highly recommended for the terminal UI and pickers
	dependencies = { "folke/snacks.nvim" },
	opts = {
		cli = {
			mux = {
				backend = "tmux",
				enabled = true,
				-- create = "window",
				create = "terminal",
			},
			---@type table<string, sidekick.cli.Config|{}>
			tools = {
				claude = { cmd = { "claude" } },
				gemini = { cmd = { "gemini" } },
			},
			picker = "snacks",
			win = {
				--- CLI Tool Keymaps (default mode is `t`)
				---@type table<string, sidekick.cli.Keymap|false>
				keys = {
					buffers = { "<c-b>", "buffers", mode = "nt", desc = "open buffer picker" },
					files = { "<c-f>", "files", mode = "nt", desc = "open file picker" },
					hide_n = { "q", "hide", mode = "n", desc = "hide the terminal window" },
					hide_ctrl_q = { "<c-q>", "hide", mode = "n", desc = "hide the terminal window" },
					hide_ctrl_dot = { "<c-.>", "hide", mode = "nt", desc = "hide the terminal window" },
					hide_ctrl_z = { "<c-z>", "hide", mode = "nt", desc = "hide the terminal window" },
					prompt = { "<c-p>", "prompt", mode = "t", desc = "insert prompt or context" },
					stopinsert = { "<c-q>", "stopinsert", mode = "t", desc = "enter normal mode" },
					-- Navigate windows in terminal mode. Only active when:
					-- * layout is not "float"
					-- * there is another window in the direction
					-- With the default layout of "right", only `<c-h>` will be mapped
					nav_left = { "<M-Left>", "nav_left", expr = true, desc = "navigate to the left window" },
					nav_down = { "<M-Right>", "nav_down", expr = true, desc = "navigate to the below window" },
					nav_up = { "<M-Up>", "nav_up", expr = true, desc = "navigate to the above window" },
					nav_right = { "<M-Down>", "nav_right", expr = true, desc = "navigate to the right window" },
				},
			},
		},
	},
	keys = {

		{
			"<leader>aa",
			function()
				require("sidekick.cli").toggle()
			end,
			desc = "Sidekick Toggle CLI",
		},
		{
			"<leader>as",
			function()
				require("sidekick.cli").select({ filter = { installed = true } })
			end,
			desc = "Select CLI",
		},
		{
			"<leader>ad",
			function()
				require("sidekick.cli").close()
			end,
			desc = "Detach a CLI Session",
		},
		{
			"<leader>at",
			function()
				require("sidekick.cli").send({ msg = "{this}" })
			end,
			mode = { "x", "n" },
			desc = "Send This",
		},
		{
			"<leader>af",
			function()
				require("sidekick.cli").send({ msg = "{file}" })
			end,
			desc = "Send File",
		},
		{
			"<leader>av",
			function()
				require("sidekick.cli").send({ msg = "{selection}" })
			end,
			mode = { "x" },
			desc = "Send Visual Selection",
		},
		{
			"<leader>ap",
			function()
				require("sidekick.cli").prompt()
			end,
			mode = { "n", "x" },
			desc = "Sidekick Select Prompt",
		},
		-- Example of a keybinding to open Claude directly
		{
			"<leader>ac",
			function()
				require("sidekick.cli").toggle({ name = "claude", focus = true })
			end,
			desc = "Sidekick Toggle Claude",
		},
		{
			"<leader>ag",
			function()
				require("sidekick.cli").toggle({ name = "gemini", focus = true })
			end,
			desc = "Sidekick Toggle Gemini",
		},
	},
	-- keys = {
	-- 	-- 1. The Universal Picker
	-- 	{ "<leader>aa", "<cmd>Sidekick cli select<cr>", desc = "Sidekick AI Menu" },
	--
	-- 	-- 2. Environment-Specific Toggles
	-- 	{ "<leader>ac", "<cmd>Sidekick cli toggle name=claude<cr>", desc = "Toggle Claude Code (Home)" },
	-- 	{ "<leader>ag", "<cmd>Sidekick cli toggle name=gemini<cr>", desc = "Toggle Gemini CLI (Work)" },
	--
	-- 	-- 3. Context Injection
	-- 	-- Normal mode: Sends the general context (file path, etc.)
	-- 	{ "<leader>as", "<cmd>Sidekick cli send<cr>", mode = "n", desc = "Send Context to AI" },
	--
	-- 	-- Visual mode: Sends the exact highlighted text
	-- 	-- Using the Lua API here guarantees the selection is captured properly
	-- 	{
	-- 		"<leader>as",
	-- 		function()
	-- 			require("sidekick.cli").send({ msg = "{selection}" })
	-- 		end,
	-- 		mode = "v",
	-- 		desc = "Send Visual Selection to AI",
	-- 	},
	-- },
}
