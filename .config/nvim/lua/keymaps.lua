local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "      -- space for leader
vim.g.maplocalleader = " " -- space for local leader

map("n", "<esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })

-- fff fuzzy finder
map("n", '<leader>pf', function() require('fff').find_files() end, { desc = 'FFFind files' })
map("n", "<leader>ps", function() require('fff').live_grep() end, { desc = 'FFFuzzy grep' })

-- oil
map("n", "<leader>pv", "<Cmd>Oil<CR>", { desc = "Open [P]arent directory [V]iew" })

-- format current buffer
map("n", "<leader>ft", "<Cmd>lua vim.lsp.buf.format()<CR>", { desc = "[F]orma[T] current buffer" })



-- split navigation
map("n", "<C-h>", "<cmd><C-U>TmuxNavigateLeft<CR>", { silent = true })
map("n", "<C-j>", "<cmd><C-U>TmuxNavigateDown<CR>", { silent = true })
map("n", "<C-k>", "<cmd><C-U>TmuxNavigateUp<CR>", { silent = true })
map("n", "<C-l>", "<cmd><C-U>TmuxNavigateRight<CR>", { silent = true })

