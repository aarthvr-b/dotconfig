local o = vim.opt

-- General settings
o.nu = true
o.relativenumber = true
o.cursorline = true
o.wrap = false
o.scrolloff = 10
o.sidescrolloff = 10

o.list = false
-- o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Indentation
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autoindent = true

-- Visual settings
o.termguicolors = true
o.signcolumn = "yes"
o.colorcolumn = "80"
o.winborder = "rounded"

-- Behavior settings
o.selection = "exclusive"
o.mouse = "a"
o.clipboard:append("unnamedplus")
o.spelllang = "en"
