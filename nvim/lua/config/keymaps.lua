vim.g.mapleader = " "
vim.g.maplocalleader = " "

local M = {

	-- Normal Mode Key Mappings
	n = {
		-- Tmux Commands
		{ lhs = "<C-h>", rhs = "<cmd> TmuxNavigateLeft<CR>", opts = { desc = "window left" } },
		{ lhs = "<C-l>", rhs = "<cmd> TmuxNavigateRight<CR>", opts = { desc = "window right" } },
		{ lhs = "<C-j>", rhs = "<cmd> TmuxNavigateDown<CR>", opts = { desc = "window down" } },
		{ lhs = "<C-k>", rhs = "<cmd> TmuxNavigateUp<CR>", opts = { desc = "window up" } },
		-- Diagnostic
		{ lhs = "<Space>", rhs = "<Nop>", opts = { desc = "Do nothing on space", silent = true } },
		{ lhs = "<Esc>", rhs = "<cmd>nohlsearch<CR>", opts = { desc = "Clear Highlihgts with Esc" } },
		-- Switch windows
		{ lhs = "<C-h>", rhs = "<C-w><C-h>", opts = { desc = "Move focus to the left window" } },
		{ lhs = "<C-l>", rhs = "<C-w><C-l>", opts = { desc = "Move focus to the right window" } },
		{ lhs = "<C-j>", rhs = "<C-w><C-j>", opts = { desc = "Move focus to the lower window" } },
		{ lhs = "<C-k>", rhs = "<C-w><C-k>", opts = { desc = "Move focus to the upper window" } },
		-- Word Wrap
		-- { lhs = "k", rhs = "v:count == 0 ? 'gk' : 'k'", opts = { expr = true, noremap = true, silent = true } },
		-- { lhs = "j", rhs = "v:count == 0 ? 'gj' : 'j'", opts = { expr = true, noremap = true, silent = true } },
		-- LSP
		-- { lhs = 'K', rhs = vim.lsp.buf.hover, opts = { } },
		-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	},

	i = {
		-- Insert Mode Key Mappings
	},

	v = {
		-- Visual Mode Key Mappings
	},

	t = {
		-- Terminal Mode Key Mappings
		{ lhs = "<Esc><Esc>", rhs = "<C-\\><C-n>", opts = { desc = "Exit Terminal Mode" } },
	},
}

for mode, mappings in pairs(M) do
	for _, mapping in ipairs(mappings) do
		-- print(mode, mapping.lhs, mapping.rhs, mapping.opts)
		if mapping.opts == nil then
			mapping.opts = {}
		end
		vim.keymap.set(mode, mapping.lhs, mapping.rhs, mapping.opts)
	end
end

-- "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
-- keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
-- keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
-- keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
--
-- keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
-- keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- for mode, mappings in pairs(M) do
--   for lhs, opts in pairs(mappings) do
--     local rhs = opts[1]
--     local desc = opts[2]
--     vim.keymap.set(mode, lhs, rhs, { desc = desc })
--   end
-- end

-- Function to toggle wrap
function toggle_wrap()
	if vim.opt.wrap:get() then
		vim.opt.wrap = false
	else
		vim.opt.wrap = true
	end
end

-- Function to shift selected lines forward by one tab
function ShiftLinesForward()
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")
	vim.api.nvim_command(":" .. start_line .. "," .. end_line .. "normal! >>")
end

function ShiftLinesBackward()
	-- Get the visual selection range
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")

	-- Apply the shift operation to each line in the selection
	vim.api.nvim_command(":" .. start_line .. "," .. end_line .. "normal! <<")
end

-- Keybindings with custom functions
vim.api.nvim_set_keymap("n", "<A-z>", ":lua toggle_wrap()<CR>", { noremap = true, silent = true })

-- Keybinding to shift selected lines forward by one tab
vim.api.nvim_set_keymap("v", "<Tab>", ":<C-u>lua ShiftLinesForward()<CR>", { noremap = true, silent = true })

-- Keybinding to shift selected lines backward by one tab
vim.api.nvim_set_keymap("v", "<S-Tab>", ":<C-u>lua ShiftLinesBackward()<CR>", { noremap = true, silent = true })

-- File Navigator
vim.keymap.set("n", "<leader>t", vim.cmd.Ex, { desc = "File Navigator" })

-- cool move line in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Paste in the next line
-- vim.keymap.set('n', 'p', 'o<Esc>p', { noremap = true, silent = true })

-- don't ask
vim.keymap.set("n", "Y", "yg$")
-- greatest remap ever
-- vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over" })
