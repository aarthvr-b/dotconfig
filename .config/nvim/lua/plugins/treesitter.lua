vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require("nvim-treesitter").setup({
	auto_install = false,
	highlight = { enable = true },
	indent = { enable = true },
	ensure_installed = {
		"markdown",
		"lua",
		"luadoc",
		"python",
		"vim",
		"json",
		"yaml",
		"bash",
		"html",
		"css",
	},
})
