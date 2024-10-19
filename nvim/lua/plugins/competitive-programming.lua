local competitest = {
	"xeluxee/competitest.nvim",
	dependencies = "MunifTanjim/nui.nvim",
	config = function()
		require("competitest").setup()
	end,
}

local leetcode = {

	"kawre/leetcode.nvim",

	build = ":TSUpdate html",

	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim", -- required by telescope
		"MunifTanjim/nui.nvim",

		-- optional
		"tree-sitter/tree-sitter-html",
		"nvim-treesitter/nvim-treesitter",
		"rcarriga/nvim-notify",
		"nvim-tree/nvim-web-devicons",
	},

	opts = {
		-- configuration goes here
		injector = {
			["cpp"] = {
				before = {
					"#include <bits/stdc++.h>",
					"using namespace std;",
				},
				after = "",
			},
		},
	},
}

return {
	leetcode,
	competitest,
}
