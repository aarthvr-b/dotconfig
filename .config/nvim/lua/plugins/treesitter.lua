return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	opts = {
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
			"c_sharp",
		},
	},
}
