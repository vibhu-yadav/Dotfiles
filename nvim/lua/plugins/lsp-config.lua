local mason = {
	"williamboman/mason.nvim",
	-- config = function()
	-- 	require("mason").setup()
	-- end,
}

-- Mason sets up the LSP servers
local mason_lspconfig = {
	"williamboman/mason-lspconfig.nvim",
	-- config = function()
	-- 	require("mason-lspconfig").setup({
	-- 		auto_install = true,
	-- 		ensure_installed = {
	-- 			"lua_ls",
	-- 			"clangd",
	-- 			"rust_analyzer",
	-- 			"pyright",
	-- 		},
	-- 	})
	-- end,
}

-- Neovim-Lsp-Config sets up the client side lsp for neovim

local nvim_lspconfig = {
	"neovim/nvim-lspconfig",

	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(key, func, desc)
					vim.keymap.set(
						{ "n", "v" },
						key,
						func,
						{ buffer = event.buf, desc = "LSP: " .. desc, noremap = true, silent = true }
					)
				end

				local tb = require("telescope.builtin")

				--
				map("gd", tb.lsp_definitions, "[G]oto [D]efinition")
				-- 		-- WARN: This is not Goto Definition, this is Goto Declaration.
				-- 		--  For example, in C this would take you to the header.
				map("gr", tb.lsp_references, "[G]oto [R]eferences")
				map("gi", tb.lsp_implementations, "[G]oto [I]mplementations")
				--  the definition of its *type*, not where it was *defined*.
				map("gt", tb.lsp_type_definitions, "[G]oto [T]ype Definition")
				-- Fuzzy find all the symbols(variables, functions, types) in your current document.
				map("<leader>ds", tb.lsp_document_symbols, "[D]ocument [S]ymbols")
				-- Fuzzy find all the symbols(variables, functions, types) in your workspace.
				-- NOTE: dynamic is more interactive, but can be slower for large projects
				-- map("<leader>ws", tb.lsp_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>ws", tb.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- Vim LSP commands [Using the built-in LSP client]
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				-- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
				local opts = { noremap = true, silent = true }
				-- map("<leader>cf", vim.lsp.buf.format, "[C]ode [F]ormat")
				map("<leader>e", vim.diagnostic.open_float, "[E]rror [M]essage")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("<leader>K", vim.lsp.buf.hover, "Hover")
				map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
				map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd")
				map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove")
				map("<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[W]orkspace [L]ist")
				map("[d", vim.diagnostic.goto_prev, "[D]iagnostic [P]revious")
				map("]d", vim.diagnostic.goto_next, "[D]iagnostic [N]ext")
				map("<leader>q", vim.diagnostic.setloclist, "[Q]uickfix List")
				-- vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, opts)
				-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
				-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				-- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
				-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
				-- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
				-- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
				-- vim.keymap.set('n', '<leader>wl', function()
				-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				-- end, opts)
				-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
				-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
				-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

				-- Highlighting and Inlay Hints
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				local supported_filetypes = { "c", "cpp", "lua", "python", "rust" }

				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documenthighlight) then
					local filetype = vim.bo[event.buf].filetype
					if vim.tbl_contains(supported_filetypes, filetype) then
						local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
							end,
						})

						if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
							map("<leader>th", function()
								vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
							end, "[T]oggle Inlay [H]ints")
						end
					end
				end
			end,
		})

		-- Server Capabilities
		local lspconfig = require("lspconfig")

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- local servers = {
		-- 	"lua_ls",
		-- 	"clangd",
		-- 	"rust_analyzer",
		-- 	"pyright",
		-- 	"clang_format",
		-- }
		--
		local servers = {
			lua_ls = {},
			clangd = {},
			rust_analyzer = {},
			pyright = {},
			jsonls = {},
			gopls = {},
			-- solidity_ls_nomicfoundation = {},
			-- vscode_solidity_server = {},
		}

		-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- for _, lsp in ipairs(servers) do
		-- 	lspconfig[lsp].setup({
		-- 		-- on_attach = custom_attach,
		-- 		capabilities = capabilities,
		-- 	})
		-- end

		require("mason").setup()

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Lua formatter
		})

		require("mason-tool-installer").setup({
			auto_install = true,
			ensure_installed = ensure_installed,
		})

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}

-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
-- used for completion, annotations and signatures of Neovim apis
local lazydev = {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			-- Load luvit types when the `vim.uv` word is found
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
		},
	},
}

-- luvit-meta
local luvit_meta = {
	"Bilal2453/luvit-meta",
	lazy = true,
}

return {
	mason,
	mason_lspconfig,
	nvim_lspconfig,
	lazydev,
	luvit_meta,
}
