local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("HighlightYank", {})
local trim_ws_group = augroup("trim_ws", {})
local file_type_group = augroup("file_type", {})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
	desc = "Highlight when Yanking text",
})

autocmd({ "BufWritePre" }, {
	group = trim_ws_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd({ "BufRead", "BufNewFile" }, {
	group = file_type_group,
	pattern = "*.cl",
	command = [[set filetype=cool]],
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		vim.opt_local.shiftwidth = 4 -- Number of spaces for each step of (auto)indent
		vim.opt_local.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
		vim.opt_local.expandtab = false -- Use tabs instead of spaces
	end,
})

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "*.c",
-- 	callback = function()
-- 		vim.opt_local.shiftwidth = 4 -- Number of spaces for each step of (auto)indent
-- 		vim.opt_local.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
-- 		vim.opt_local.expandtab = false -- Use tabs instead of spaces
-- 	end,
-- })

-- Disable LSP and Treesitter for .txt files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "txt",
	callback = function()
		-- Disable LSP
		-- for _, client in pairs(vim.lsp.get_active_clients()) do
		for _, client in pairs(vim.lsp.get_clients()) do
			if client.config.filetypes and vim.tbl_contains(client.config.filetypes, "txt") then
				vim.lsp.stop_client(client.id)
			end
		end

		-- Disable Treesitter
		require("nvim-treesitter.configs").setup({
			highlight = { enable = false },
			indent = { enable = false },
		})
	end,
})

-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "leetcode.nvim",
-- 	callback = function()
-- 		print("Inside Leetcode")
-- 		vim.api.nvim_buf_set_keymap(0, "n", "<C-'>", "<cmd>Leet run<CR>", { noremap = true, silent = true })
-- 		vim.api.nvim_buf_set_keymap(0, "n", "<C-CR>", "<cmd>Leet submit<CR>", { noremap = true, silent = true })
-- 		vim.api.nvim_buf_set_keymap(0, "n", "<C-i>", "<cmd>Leet info<CR>", { noremap = true, silent = true })
-- 	end,
-- })
