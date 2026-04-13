vim.pack.add({
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
})

vim.pack.add({
	{ src = "https://github.com/dmtrKovalenko/fff.nvim" },
}, { load = false })

vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
}, { load = false })

vim.g.fff = {
	lazy_sync = true,
	debug = {
		enabled = false,
		show_scores = false,
	},
}

local loaded = {
	fff = false,
	oil = false,
}
local oil_setup_done = false

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

function _G.LoadOil()
	load_plugin("oil.nvim")
	local oil = require("oil")
	if not oil_setup_done then
		oil.setup({
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["<C-h>"] = false,
				["<C-l>"] = false,
			},
		})
		oil_setup_done = true
	end
	return oil
end
