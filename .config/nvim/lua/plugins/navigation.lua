vim.pack.add({
	{ src = "https://github.com/dmtrKovalenko/fff.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
})

vim.g.fff = {
	lazy_sync = true,
	debug = {
		enabled = false,
		show_scores = false,
	},
}

require("oil").setup({
	view_options = {
		show_hidden = true,
	},
	keymaps = {
		["<C-h>"] = false,
		["<C-l>"] = false,
	},
})
