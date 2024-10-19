local autopairs = {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = true,
	-- use opts = {} for passing setup options
	-- this is equivalent to setup({}) function
}

local cmp_nvim_lsp = {
	"hrsh7th/cmp-nvim-lsp",
}

local luasnip = {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	dependencies = {
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"hrsh7th/cmp-path",
	},

	config = function()
		require("luasnip.loaders.from_vscode").lazy_load({
			paths = {
				"~/.config/nvim/snippets",
			},
		})
		-- vim.api.nvim_set_keymap("i", "<Tab>",
		-- 	"luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", { expr = true })
		-- vim.api.nvim_set_keymap("s", "<Tab>", "<cmd>lua require'luasnip'.jump(1)<Cr>", { silent = true })
		-- vim.api.nvim_set_keymap("s", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<Cr>", { silent = true })
	end,
}

local nvim_cmp = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	config = function()
		local cmp = require("cmp")
		local lsnip = require("luasnip")
		-- luasnip.config.set_config({})

		-- require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({

			snippet = {
				expand = function(args)
					lsnip.lsp_expand(args.body)
				end,
			},

			completion = {
				completeopt = "menu,menuone,noinsert",
			},

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			mapping = cmp.mapping.preset.insert({

				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),

				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),

				["<C-y>"] = cmp.mapping.confirm({ select = true }),

				-- To revert to vscode style keybindings
				--['<CR>'] = cmp.mapping.confirm { select = true },
				--['<Tab>'] = cmp.mapping.select_next_item(),
				--['<S-Tab>'] = cmp.mapping.select_prev_item(),

				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				-- ["<CR>"] = cmp.mapping.confirm({ select = true }),

				-- <c-l> will move you to the right of each of the expansion locations.
				-- <c-h> is similar, except moving you backwards.
				["<C-l>"] = cmp.mapping(function()
					if lsnip.expand_or_locally_jumpable() then
						lsnip.expand_or_jump()
					end
				end, { "i", "s" }),

				["<C-h>"] = cmp.mapping(function()
					if lsnip.locally_jumpable(-1) then
						lsnip.jump(-1)
					end
				end, { "i", "s" }),

				-- Luasnip keymaps config @ https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
			}),
			sources = cmp.config.sources({
				{ name = "lazydev", group_index = 0 }, -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
				{ name = "path" },
			}, {
				{ name = "buffer" },
			}),
		})
	end,
}

local copilot = {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_enabled = 1
		vim.g.copilot_filetypes = {
			cpp = false,
			rust = false,
		}
	end,
}

return {
	autopairs,
	cmp_nvim_lsp,
	nvim_cmp,
	luasnip,
	-- copilot,
}
