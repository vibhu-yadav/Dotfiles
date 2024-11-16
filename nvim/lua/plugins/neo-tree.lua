return {

	"nvim-neo-tree/neo-tree.nvim",

	branch = "v3.x",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},

	-- cmd = 'Neotree',

	opts = {
		source_selector = {
			winbar = false,
		},
		sources = {
			"filesystem",
			"buffers",
			"git_status",
			-- "diagnostics",
		},
		filesystem = {
			hijack_netrw_behavior = "disabled",
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,
			},
		},
	},

	config = function(_, opts)
		require("neo-tree").setup(opts)
		local position = "float"
		vim.keymap.set(
			"n",
			"<C-b>",
			": Neotree filesystem reveal " .. position .. " toggle<CR>",
			{ desc = "Toggle Neo Tree" }
		)
	end,
}
