auto_session = {
	lazy = false,
	"rmagatti/auto-session",
	dependencies = {
		"nvim-telescope/telescope.nvim", -- Only needed if you want to use session lens
	},

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		auto_save = false,
		lazy_support = true,
		session_lens = {
			load_on_setup = true,
		},
		-- log_level = 'debug',
	},

	config = function(_, opts)
		require("auto-session").setup(opts)
		vim.api.nvim_set_keymap("n", "<C-s>", "<cmd>SessionSave<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<C-q>", "<cmd>qa!<CR>", { noremap = true, silent = true })
	end,
}

return {
	auto_session,
}
