return {

	"folke/which-key.nvim",

	-- event = "VeryLazy",
	event = "VimEnter",

	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		icons = {
			mappings = vim.g.have_nerd_font,
			keys = vim.g.have_nerd_font and {} or {
				Up = '<Up> ',
				Down = '<Down> ',
				Left = '<Left> ',
				Right = '<Right> ',
				C = '<C-…> ',
				M = '<M-…> ',
				D = '<D-…> ',
				S = '<S-…> ',
				CR = '<CR> ',
				Esc = '<Esc> ',
				ScrollWheelDown = '<ScrollWheelDown> ',
				ScrollWheelUp = '<ScrollWheelUp> ',
				NL = '<NL> ',
				BS = '<BS> ',
				Space = '<Space> ',
				Tab = '<Tab> ',
				F1 = '<F1>',
				F2 = '<F2>',
				F3 = '<F3>',
				F4 = '<F4>',
				F5 = '<F5>',
				F6 = '<F6>',
				F7 = '<F7>',
				F8 = '<F8>',
				F9 = '<F9>',
				F10 = '<F10>',
				F11 = '<F11>',
				F12 = '<F12>',
				{ "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)", },
			},
		},
	},

	-- Nested mappings are allowed and can be added in any order
	-- Most attributes can be inherited or overridden on any level
	-- There's no limit to the depth of nesting
	config = function(_, opts)
		require("which-key").setup(opts)
		require("which-key").add({

			{ "<leader>c",  group = "[C]ode" },
			{ "<leader>d",  group = "[D]ocument" },
			{ "<leader>r",  group = "[R]ename" },
			{ "<leader>s",  group = "[S]earch" },
			{ "<leader>w",  group = "[W]orkspace" },
			{ "<leader>t",  group = "[T]oggle" },
			{ "<leader>h",  group = "Git [H]unk", mode = { "n", "v" } },

			{ "<leader>f",  group = "Find" }, -- group
			{ "<leader>d",  group = "Debug" },
			{ "<leader>g",  group = "Git" },
			{ "<leader>v",  group = "Lsp" },
			{ "<leader>fn", desc = "New File" },
			{ "<leader>f1", hidden = true },                 -- hide this keymap
			{ "<leader>w",  proxy = "<c-w>",      group = "windows" }, -- proxy to window mappings
			{ "<leader>b",  group = "buffers",    expand = function() return require("which-key.extras").expand.buf() end },
			{
				mode = { "n", "v" },                  -- NORMAL and VISUAL mode
				{ "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
				{ "<leader>w", "<cmd>w<cr>", desc = "Write" },
			}
		})

		vim.keymap.set("n", "<C-h>", "<cmd>:WhichKey<CR>", { silent = true, desc = "Show which-key help" })
	end,
}
