-- Formatters

local M = {}

M.conform = { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				-- I want to print what formatter is being used
				-- print("Formatting Code" .. vim.bo.filetype .. "with ")
				require("conform").format({
					async = true,
					-- lsp_fallback = true,
					lsp_format = "fallback",
					-- stop_after_first = true
				})
			end,
			mode = { "n", "i", "v" },
			desc = "[C]ode [F]ormat (Conform)",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			--
			local disable_filetypes = {
				txt = true,
				json = false,
				-- c = true,
				-- cpp = true
			}

			return {
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			-- Conform can also run multiple formatters sequentially
			-- You can use 'stop_after_first' to run the first available formatter from the list
			lua = { "stylua", "lua_ls", stop_after_first = true },
			python = { "isort", "black", stop_after_first = true },
			rust = { "rustfmt", lsp_format = "fallback", stop_after_first = true },
			c = { "clang-format", stop_after_first = true },
			cpp = { "clang-format", stop_after_first = true },
			javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
			-- json = { "biome", "fixjson", "clnag-format", "prettier", stop_after_first = true },
			json = { "biome" },
			solidity = { "prettier_with_solidity", "prettier", stop_after_first = true },
		},
	},
}

M.vim_prettier = {
	"prettier/vim-prettier",
	run = "npm install",
	ft = {
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"css",
		"less",
		"scss",
		"json",
		"graphql",
		"markdown",
		"vue",
		"yaml",
		"html",
		"cpp",
	},
	config = function()
		require("vim-prettier.").setup({})
		vim.api.nvim_set_keymap("n", "<leader>cf", ":Prettier<CR>", { noremap = true, silent = true })
	end,
}

M.none_ls = {
	"nvimtools/none-ls.nvim",

	config = function()
		local null_ls = require("null-ls")
		local mason_registry = require("mason-registry")

		local formatters = {
			clang_format = "clang-format",
			rustfmt = "rustfmt",
			stylua = "stylua",
			prettier = "prettier",
			black = "black",
			gofmt = "gofmt",
			goimports = "goimports",
			autopep8 = "autopep8",
			isort = "isort",
			prettier_with_solidity = "pretteri",
		}

		local function executable_exists(name)
			return vim.fn.executable(name) > 0
		end

		-- -- Set up formatters and linters
		local sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettier,
			null_ls.builtins.diagnostics.eslint_d,
			null_ls.builtins.formatting.clang_format,
		}
		--
		for formatter, executable in pairs(formatters) do
			if executable_exists(executable) then
				table.insert(sources, null_ls.builtins.formatting[formatter])
			end
		end

		-- Ensure prettier is correctly set up for JSON
		if executable_exists("prettier") then
			table.insert(
				sources,
				null_ls.builtins.formatting.prettier.with({
					filetypes = { "json", "jsonc" }, -- Add JSON filetypes
				})
			)
		end

		null_ls.setup({
			sources = sources,
		})
	end,
}

return M.conform
