local toggleterm = {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = [[<c-t>]],
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})

		-- Map <Esc><Esc> to close the terminal
		vim.api.nvim_set_keymap("t", "<Esc><Esc>", "<C-\\><C-n><cmd>ToggleTerm<CR>", { noremap = true, silent = true })
	end,
}

return {
	toggleterm,
}
