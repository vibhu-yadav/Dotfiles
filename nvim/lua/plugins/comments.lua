local nerdcommenter = {
	"preservim/nerdcommenter",

	config = function()
		vim.cmd("filetype plugin on")
	end,
}

local neogen = {
	"danymat/neogen",

	version = "*",

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"L3MON4D3/LuaSnip",
	},

	config = function()
		local neogen = require("neogen")

		neogen.setup({

			enabled = true, -- Enable the plugin

			snippet_engine = "luasnip",

			languages = {

				python = {
					template = {
						annotation_convention = "google_docstrings", -- You can use "numpydoc" or "reST" as well
					},
				},

				c = {
					template = {
						annotation_convention = "doxygen", -- Doxygen style for C
					},
				},

				cpp = {
					template = {
						annotation_convention = "doxygen", -- Doxygen style for C++
					},
				},

				rust = {
					template = {
						annotation_convention = "rustdoc", -- Rust documentation style
					},
				},

				java = {
					template = {
						annotation_conventation = "javadoc", -- Java Documentation Style
					},
				},

				typescript = {
					template = {
						annotation_conventation = "tsdoc", -- Typescript Documentation Style
					},
				},

				javascript = {
					template = {
						annotation_conventation = "jsdoc", -- Javascript Documentation Style
					},
				},
			},
		})

		-- Key mappings to generate annotations
		vim.api.nvim_set_keymap(
			"n",
			"<leader>cg",
			':lua require("neogen").generate()<CR>',
			{ noremap = true, silent = true }
		)

		-- Key mappings to generate Types, Functions, Class
		vim.api.nvim_set_keymap(
			"n",
			"<Leader>nt",
			":lua require('neogen').generate({ type = 'type' })<CR>",
			{ noremap = true, silent = true, desc = "Generate Type" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<Leader>nf",
			":lua require('neogen').generate({ type = 'func' })<CR>",
			{ noremap = true, silent = true, desc = "Generate Function" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<Leader>nc",
			":lua require('neogen').generate({ type = 'class' })<CR>",
			{ noremap = true, silent = true, desc = "Generate Class" }
		)
	end,
	-- Uncomment next line if you want to follow only stable versions
}

return {
	nerdcommenter,
	neogen,
}
