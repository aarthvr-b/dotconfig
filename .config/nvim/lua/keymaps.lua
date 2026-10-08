local map = vim.keymap.set

map("n", "<esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bs", "<cmd>buffers<CR>", { desc = "Show current buffers" })

map("n", "<leader>ft", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]orma[T] current buffer" })

-- Select lines, press <leader>`: wraps them in a code fence and puts the cursor
-- after the opening backticks so you can type the language right away
map("x", "<leader>`", function()
	vim.cmd("normal! \27") -- leave visual mode so the '< and '> marks are set
	local first = vim.fn.line("'<")
	local last = vim.fn.line("'>")
	vim.api.nvim_buf_set_lines(0, last, last, false, { "```" })
	vim.api.nvim_buf_set_lines(0, first - 1, first - 1, false, { "```" })
	vim.api.nvim_win_set_cursor(0, { first, 3 })
	vim.cmd("startinsert!")
end, { desc = "Wrap lines in code fence" })

-- Plugin keymaps live in each plugin spec's `keys` (lua/plugins/*.lua).
-- LSP keymaps live in lua/lsp/init.lua.
