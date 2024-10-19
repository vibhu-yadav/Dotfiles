local M = {}

M.dashboard = {
		'nvimdev/dashboard-nvim',
		event = 'VimEnter',
		config = function()
			require('dashboard').setup({
				theme = 'hyper',
				shortcut_type = "number",
				shuffle_letter = "false",
				config = {
					-- Theme Config
				},
				hide = {
					statusline,
					tabline,
					winbar,
				},
				preview = {
					command,
					file_path,
					file_height,
					file_width,
				}
			})
		end,
		dependencies = { { 'nvim-tree/nvim-web-devicons' } }
	}

M.startup = {

	"startup-nvim/startup.nvim",

	event = "VimEnter",

	lazy = false,

	priority = 1000,

	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},

	config = function()
		require("startup").setup({
			theme = "dashboard",  -- dashboard, evil, startify
		})
	end,
}

return M.startup
