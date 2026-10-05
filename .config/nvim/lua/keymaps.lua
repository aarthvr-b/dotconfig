local map = vim.keymap.set

map("n", "<esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bs", "<cmd>buffers<CR>", { desc = "Show current buffers" })

map("n", "<leader>ft", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]orma[T] current buffer" })

-- Plugin keymaps live in each plugin spec's `keys` (lua/plugins/*.lua).
-- LSP keymaps live in lua/lsp/init.lua.
