local map = vim.keymap.set

vim.g.mapleader = " " -- space for leader
vim.g.maplocalleader = " " -- space for local leader

map("n", "<esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })

-- fff fuzzy finder
map("n", "<leader>pf", function()
	_G.LoadFff().find_files()
end, { desc = "FFFind files" })
map("n", "<leader>ps", function()
	_G.LoadFff().live_grep()
end, { desc = "FFFuzzy grep" })

-- oil
map("n", "<leader>pv", function()
	_G.LoadOil().open()
end, { desc = "Open [P]arent directory [V]iew" })

-- format current buffer

-- split navigation
map("n", "<C-h>", "<cmd><C-U>TmuxNavigateLeft<CR>", { silent = true })
map("n", "<C-j>", "<cmd><C-U>TmuxNavigateDown<CR>", { silent = true })
map("n", "<C-k>", "<cmd><C-U>TmuxNavigateUp<CR>", { silent = true })
map("n", "<C-l>", "<cmd><C-U>TmuxNavigateRight<CR>", { silent = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local opts = { buffer = ev.buf }

		map("n", "gd", vim.lsp.buf.definition, opts, { desc = "[G]o to [D]efinition" })
		map("n", "<leader>hh", vim.lsp.buf.hover, opts, { desc = "[H]over on a code" })
		map("n", "gi", vim.lsp.buf.implementation, opts, { desc = "[G]o to [I]mplementation" })
		map("n", "<leader>D", vim.lsp.buf.type_definition, opts, { desc = "Type [D]efinition" })
		map("n", "<leader>rn", vim.lsp.buf.rename, opts, { desc = "[R]ename" })
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts, { desc = "[C]ode [A]ction" })
		map("n", "gr", vim.lsp.buf.references, opts, { desc = "[Go] to [R]eferences" })
		map("n", "<leader>ft", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, opts, { desc = "[F]orma[T] current buffer" })

		-- Open the diagnostic under the cursor in a float window
		map("n", "<leader>d", function()
			vim.diagnostic.open_float({ border = "rounded" })
		end, opts, { desc = "Open diagnostic under cursor in float window" })
	end,
})
