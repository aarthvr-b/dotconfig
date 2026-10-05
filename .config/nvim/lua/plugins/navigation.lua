return {
	{
		"stevearc/oil.nvim",
		opts = { view_options = { show_hidden = true } },
	},

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
		},
	},
}
