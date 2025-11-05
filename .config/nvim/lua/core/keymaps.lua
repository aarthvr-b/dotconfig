vim.g.mapleader = " "
vim.g.maplocalleader = " "

local vks = vim.keymap.set

vks("n", "<leader>bd", ":bd!<CR>", { desc = "Delete current Buffer" })
vks("n", "<leader>ww", ":write<CR>", { desc = "Write document" })
vks("n", "<leader>qq", ":q!<CR>", { desc = "Quit without saving" })
vks("n", "<leader>bn", ":bnext <CR>", { desc = "Tab goes to next Buffer" })
vks("n", "<leader>bp", ":bprevious <CR>", { desc = "Tab goes to next Buffer" })
vks("n", "<leader>pv", ":Ex<CR>", { desc = "Toggle netrw tree view" })

-- Togglers
vks('n', '<leader>wr', ":set wrap! <CR>", { desc = 'activates word wrap setting'})
vks('n', '<leader>h', ":nohlsearch<CR>", { desc = "Clear search highlights"})

-- Visual Keymaps
vks("v","<leader>rh", "\"hy:%s/<C-r>h//g<left><left>") -- In Visual mode find and replace selected section
vks("v","J", ":m '>+1<CR>gv=gv") -- Move selected row down
vks("v","K", ":m '>-2<CR>gv=gv") -- Move selected row up

-- easier interaction with the system Clipboard
vks({'n','x'}, '<leader>yy', '"+y', { desc = 'copy to system Clipboard'})
vks({'n','x'}, '<leader>pp', '"+p', { desc = 'Paste from system Clipboard after cursor'})
vks({'n','x'}, '<leader>PP', '"+P', { desc = 'Paste from system Clipboard before cursor'})

-- indenting
vks('v', '<', '<gv', { silent = true, noremap = true, desc = 'Indent selected to the left'})
vks('v', '>', '>gv', { silent = true, noremap = true, desc = 'Indent selection to the right'})

