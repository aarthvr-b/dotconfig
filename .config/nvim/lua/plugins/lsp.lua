return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls", -- Lua
				"pyright", -- Python
				"ruff", -- Python linting
				"ts_ls", -- JavaScript / TypeScript
				"csharp_ls", -- C#
			},
		},
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		opts = {},
	},
}
