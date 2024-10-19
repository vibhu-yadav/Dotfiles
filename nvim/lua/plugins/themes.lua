-- themes.lua

-- local lazy = require("lazy")

local themes = {}

-- To auto switch between light theme at night and dark during day
-- local hr = tonumber(os.date('%H', os.time()))
-- if hr > 6 and hr < 21 then
--     vim.opt.background = "light"
-- else
--     vim.opt.background = "dark"
-- end

themes.rosepine = {

	"rose-pine/neovim",

	lazy = false,
	priority = 1000,
	opts = {
		-- auto, main, moon, dawn
		variant = "moon",
		-- -- main, moon, or dawn
		-- dark_variant = "dawn",
	},

	config = function(_, opts)
		require("rose-pine").setup(opts)
		vim.cmd("colorscheme rose-pine")
	end,
}

themes.onedark = {

	"navarasu/onedark.nvim",

	lazy = false,
	priority = 1000,
	opts = {
		-- Options: dark, darker, cool, deep, warm, warmer, light
		style = "darker",
		background = "dark",
	},

	config = function(_, opts)
		require("onedark").setup(opts)
		vim.cmd("colorscheme onedark")

		-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end,
}

themes.catppuccin = {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
	opts = {
		theme = "mocha", -- latte, frappe, macchiato, mocha
	},

	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd("colorscheme catppuccin-" .. opts.theme)
	end,
}

themes.nord = {

	"shaunsingh/nord.nvim",
	lazy = false,
	priority = 1000,
	opts = {},

	config = function()
		-- require("nord").setup(opts)
		vim.cmd("colorscheme nord")
	end,
}

themes.dracula = {

	"Mofiqul/dracula.nvim",
	lazy = false,
	priority = 1000,
	opts = {},

	-- lualine setup
	-- lualine = function()
	--     require("lualine").setup{
	--         options = {
	--             theme = 'dracula-nvim'
	--         },
	--     }
	-- end,

	config = function(_, opts)
		require("dracula").setup(opts)
		vim.cmd("colorscheme dracula")
	end,
}

themes.tokyonight = {

	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "moon", -- Choose between 'storm', 'night', 'day', 'moon'
		transparent = false,
		terminal_colors = true,
		styles = {
			comments = { italic = true },
			keywords = { italic = true },
			functions = {},
			variables = {},
		},
		sidebars = "dark",
		floats = "dark",
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd("colorscheme tokyonight")
	end,
}

themes.oceanic_next = {

	"mhartington/oceanic-next",
	name = "oceanic-next",
	lazy = false,
	priority = 1000,

	config = function()
		vim.opt.termguicolors = true
		vim.cmd("colorscheme OceanicNext")
	end,
}

themes.blueloco = {

	"uloco/bluloco.nvim",
	name = "bluloco",
	lazy = false,
	priority = 1000,
	dependencies = { "rktjmp/lush.nvim" },
	opts = {
		style = "auto", -- auto, dark, light
		transparent = false,
		italics = true,
		terminal = vim.fn.has("gui_running") == 1, -- bluloco colors are enabled in gui terminals
		guicursor = true,
	},

	config = function(_, opts)
		require("bluloco").setup(opts)
		vim.cmd("colorscheme bluloco")
	end,
}

themes.nightfox = {

	"EdenEast/nightfox.nvim",

	lazy = false,
	priority = 1000,

	opts = {
		-- options : nordfox, nightfox, duskfox, terafox, dayfox, dawnfox
		theme = "nordfox",
		styles = {
			comments = "italic",
			keywords = "bold",
			types = "italic,bold",
		},
	},

	config = function(_, opts)
		require("nightfox").compile(opts)
		vim.cmd("colorscheme " .. opts.theme)
	end,
}

themes.kanagawa = {

	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	lazy = false,
	priority = 1000,

	opts = {
		style = "wave", -- dragon, lotus, wave
	},

	config = function(_, opts)
		require("kanagawa").load(opts.style)
		vim.cmd.colorscheme = "kanagawa"
	end,
}

themes.witch = {

	"sontungexpt/witch",
	priority = 1000,
	lazy = false,
	opts = {
		theme = {
			style = "dark", -- dark, light
			extras = {
				bracket = true,
				dashboard = true,
				diffview = true,
				explorer = true,
				indentline = true,
			},
		},
	},

	config = function(_, opts)
		require("witch").setup(opts)
		-- vim.cmd("colorscheme witch")
	end,
}

themes.neon = {

	"rafamadriz/neon",
	priority = 1000,
	lazy = false,
	opts = {
		theme = "default", -- default, doom, light, dark
	},

	config = function(_, opts)
		require("neon").setup(opts)
	end,
}

return themes.catppuccin
