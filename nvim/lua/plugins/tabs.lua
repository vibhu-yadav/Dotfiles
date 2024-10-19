local M = {}

M.tabby = {
	'nanozuki/tabby.nvim',
	event = 'VimEnter', -- if you want lazy load, see below
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		vim.o.showtabline = 2
		vim.opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'
		-- configs...
	end,
}

M.heirline = {
	"rebelot/heirline.nvim",
	lazy = false,
	config = function()
		-- Uncomment this to load the plugin
		require("heirline").setup({})
	end,
}

M.bufferline = {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({})
	end,
}

M.cokeline = {
	"willothy/nvim-cokeline",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required for v0.4.0+
		"nvim-tree/nvim-web-devicons", -- If you want devicons "stevearc/resession.nvim" -- Optional, for persistent history
	},
	config = function()
		-- Reference for options : https://github.com/willothy/nvim-cokeline/blob/main/doc/cokeline.txt (LINE 169)
		require("cokeline").setup({
			show_if_buffers_are_at_least = 2, -- Show Tabs only if 2 buffers are open
			-- focus_on_delete = "next", -- Focus the next buffer when deleting a buffer
			-- new_buffers_position = "last", -- Position of new buffers [last, next, directory, number]
			-- delete_on_right_click = true, -- Delete buffer on right click
		})

		vim.api.nvim_set_keymap("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
		vim.api.nvim_set_keymap("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
		vim.api.nvim_set_keymap('n', '<C-n>', "<Plug>(cokeline-switch-next)", { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<C-p>', "<Plug>(cokeline-switch-prev)", { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<S-t>', ":tabnew<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<S-q>', ":bd<CR>", { noremap = true, silent = true })

		for i = 1, 9 do
			vim.api.nvim_set_keymap("n", ("<M-%s>"):format(i), ("<plug>(cokeline-focus-%s)"):format(i),
				{ silent = true })
			-- vim.api.nvim_set_keymap( "n",("<C-M-%s>"):format(i),("<plug>(cokeline-switch-%s)"):format(i),{ silent = true } )
		end
	end
}

return {}
-- return M.cokeline
