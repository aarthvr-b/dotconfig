vim.opt.termguicolors = true
vim.pack.add({
	{ src = "https://github.com/bluz71/vim-moonfly-colors", name = "moonfly" },
})
vim.cmd.colorscheme("moonfly")

-- ============
-- OPTIONS
-- ===========
require("options")

-- ============
-- KEYMAPS
-- ===========
require("keymaps")

-- ============
-- PLUGINS
-- ===========
require("plugins")

-- ============
-- LSPs
-- ===========
require("lsp")
