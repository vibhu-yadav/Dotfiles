return {


	-- nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- last release is way too old and doesn't work on Windows
		-- build = ":TSUpdate",
		run = ":TSUpdate",

		config = function()

			-- Treesitter-powered folding
			-- vim.opt.foldmethod = "expr"
			-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			-- vim.api.nvim_set_keymap('n', '<leader>z', 'za', { noremap = true, silent = true }) -- Toggle fold
			-- vim.api.nvim_set_keymap('n', '<leader>zc', 'zc', { noremap = true, silent = true }) -- Close fold
			-- vim.api.nvim_set_keymap('n', '<leader>zo', 'zo', { noremap = true, silent = true }) -- Open fold


			local configs = require("nvim-treesitter.configs")

			configs.setup({
				auto_install = true,
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"lua",
					"rust",
					"python",
					"go",
					"javascript",
					"typescript",
					"html",
					"diff",
					"markdown",
					"markdown_inline",
					"vim",
					"vimdoc",
					"luadoc",
				},
				sync_install = false,
				ignore_install = {},
				modules = {
					-- playground = {
					-- 	enable = true,
					-- }
				},
				highlight = { enable = true },

				indent = { enable = true },
			})
		end,

		-- config = vim.defer_fn(function()
		-- 	local configs = require("nvim-treesitter.configs")
		--
		-- 	configs.setup({
		-- 		auto_install = true,
		-- 		ensure_installed = {
		-- 			"bash",
		-- 			"c",
		-- 			"cpp",
		-- 			"lua",
		-- 			"rust",
		-- 			"python",
		-- 			"go",
		-- 			"javascript",
		-- 			"typescript",
		-- 			"html",
		-- 			"diff",
		-- 			"markdown",
		-- 			"markdown_inline",
		-- 			"vim",
		-- 			"vimdoc",
		-- 			"luadoc",
		-- 		},
		-- 		sync_install = false,
		-- 		ignore_install = {},
		-- 		modules = {
		-- 			-- playground = {
		-- 			-- 	enable = true,
		-- 			-- }
		-- 		},
		-- 		highlight = { enable = true },
		--
		-- 		indent = { enable = true },
		--
		-- 		incremental_selection = {
		-- 			enable = true,
		-- 			keymaps = {
		-- 				init_selection = "<c-space>",
		-- 				node_incremental = "<c-space>",
		-- 				scope_incremental = "<c-s>",
		-- 				node_decremental = "<M-space>",
		-- 			},
		-- 		},
		--
		-- 		textobjects = {
		-- 			select = {
		-- 				enable = true,
		-- 				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
		-- 				keymaps = {
		-- 					-- You can use the capture groups defined in textobjects.scm
		-- 					["aa"] = "@parameter.outer",
		-- 					["ia"] = "@parameter.inner",
		-- 					["af"] = "@function.outer",
		-- 					["if"] = "@function.inner",
		-- 					["ac"] = "@class.outer",
		-- 					["ic"] = "@class.inner",
		-- 				},
		-- 			},
		-- 			move = {
		-- 				enable = true,
		-- 				set_jumps = true, -- whether to set jumps in the jumplist
		-- 				goto_next_start = {
		-- 					["]m"] = "@function.outer",
		-- 					["]]"] = "@class.outer",
		-- 				},
		-- 				goto_next_end = {
		-- 					["]M"] = "@function.outer",
		-- 					["]["] = "@class.outer",
		-- 				},
		-- 				goto_previous_start = {
		-- 					["[m"] = "@function.outer",
		-- 					["[["] = "@class.outer",
		-- 				},
		-- 				goto_previous_end = {
		-- 					["[M"] = "@function.outer",
		-- 					["[]"] = "@class.outer",
		-- 				},
		-- 			},
		-- 			swap = {
		-- 				enable = true,
		-- 				swap_next = {
		-- 					["<leader>a"] = "@parameter.inner",
		-- 				},
		-- 				swap_previous = {
		-- 					["<leader>A"] = "@parameter.inner",
		-- 				},
		-- 			},
		-- 		},
		--
		-- 	})
		-- end, 0)
	},

}
