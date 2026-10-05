-- Leaders must be set before any mappings or lazy.nvim are loaded
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")
require("keymaps")
require("lazy_init")
require("lsp")
