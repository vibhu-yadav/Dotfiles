local g = {

	have_nerd_font = true,

	-- Netrw
	loaded_netrw = 1, -- Disable netrw
	loaded_netrwPlugin = 1, -- Disable netrw
}

vim.o.mouse = "a"

local options = {

	-- Number
	number = true, -- line number
	relativenumber = true, -- relative line number

	-- Clipboard
	clipboard = "unnamedplus", -- Sync with device clipboard

	-- Search
	hlsearch = true, -- Highlight search
	ignorecase = true, -- Ignore case in search
	smartcase = true, -- Ignore case in search if pattern is all lowercase

	-- Inccommand
	-- It controls the behavious of :substitute and :g commands while typing, for real-time feedback
	-- "nosplit" : show live preview without splitting the window
	-- "split" : show live preview in a split window
	inccommand = "split",

	-- Display
	mouse = "a", -- Enable mouse support
	showmode = false, -- Don't show mode since we have statusline
	cursorline = true, -- Highlight current line
	scrolloff = 10, -- Number of lines to keep above and below the cursor

	-- Indentation
	expandtab = false, -- Use tabs instead of spaces
	tabstop = 4, -- Number of spaces that a <Tab> in the file counts for
	softtabstop = 4, -- Number of spaces that a <Tab> counts for while editing (tab / backspace)
	shiftwidth = 4, -- Number of spaces to use for each step of (auto)indent (through >> and <<)
	autoindent = true, -- Copy indent from current line when starting a new line
	breakindent = true, -- Indent wrapped lines
	backspace = "indent,eol,start", -- allow backspace on indent, eol or insert mode start position

	-- File settings
	undofile = true, -- Save undo history to file
	undolevels = 1000, -- Number of changes that can be undone
	signcolumn = "yes", -- Always show sign column
	updatetime = 250, -- Time in ms to write swap file
	timeoutlen = 300, -- Time in ms to wait for a mapped sequence to complete

	-- Splitting
	splitright = true, -- Split to the right when creating a vertical split
	splitbelow = true, -- Split below when creating a horizontal split

	-- List
	list = true, -- Show listchars
	listchars = {
		tab = "»·", -- Tab Character
		trail = "·", -- Show trailing spaces as ·
		nbsp = "␣", -- Show non-breaking spaces as ␣
		eol = "↲", -- Show end of line as ↲
		extends = "→", -- Line extends beyond the window
		precedes = "←", -- Line precedes the window
	},

	-- Auto completion
	-- menu: Displays a menu with possible completions
	-- menuone: Displays the menu even if there is only one completion item.
	-- noselect: Prevents automatic selection of the first completion item, requiring the user to manually select from the list.
	-- noinsert: Prevents automatic insertion of the selected coumpletion item; the user must manually confirm or select from the menu.
	-- preview: Shows a preview of the selected completion item.
	completeopt = "menuone,noselect",

	-- Terminal Colors
	termguicolors = true,
}

for k, v in pairs(g) do
	vim.g[k] = v
end

for k, v in pairs(options) do
	vim.opt[k] = v
end
