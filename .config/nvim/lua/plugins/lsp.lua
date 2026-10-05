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
				"eslint", -- JavaScript / TypeScript linting
			},
			-- servers are enabled manually in lua/lsp/init.lua
			automatic_enable = false,
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
			},
		},
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		opts = {
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},
		},
	},
}
