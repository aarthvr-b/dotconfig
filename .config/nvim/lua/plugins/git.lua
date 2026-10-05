return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufWinEnter",
		opts = {
			signs = {
				add = { text = "\u{2590}" },
				change = { text = "\u{2590}" },
				delete = { text = "\u{2590}" },
				topdelete = { text = "\u{25e6}" },
				changedelete = { text = "\u{25cf}" },
				untracked = { text = "\u{25cb}" },
			},
			signcolumn = true,
			current_line_blame = false,
		},
	},
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"sindrets/diffview.nvim", -- optional
			"folke/snacks.nvim", -- optional
		},
		cmd = "Neogit",
	},
}
