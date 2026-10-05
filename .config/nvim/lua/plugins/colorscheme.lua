return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = true,
	},
}
