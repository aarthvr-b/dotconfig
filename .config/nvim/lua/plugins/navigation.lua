vim.pack.add({
	{ src = "https://github.com/dmtrKovalenko/fff.nvim" },
}, { load = false })

vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
})

vim.g.fff = {
	lazy_sync = true,
	debug = {
		enabled = false,
		show_scores = false,
	},
}

local loaded = {
	fff = false,
}

local function load_plugin(name)
	if loaded[name] then
		return
	end

	vim.cmd.packadd(name)
	loaded[name] = true
end

function _G.LoadFff()
	load_plugin("fff.nvim")
	return require("fff")
end

require("oil").setup({
	view_options = {
		show_hidden = true,
	},
	keymaps = {
		["<C-h>"] = false,
		["<C-l>"] = false,
	},
})
