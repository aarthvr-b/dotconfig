local vo = vim.opt

vo.number = true -- line number
vo.relativenumber = true -- relative line numbers
vo.cursorline = true -- highlight current line
vo.wrap = false -- do not wrap lines
vo.scrolloff = 10 -- keep 10 lines above/below cursor
vo.sidescrolloff = 10 -- keep 10 horizontally

vo.tabstop = 4 -- tab width
vo.shiftwidth = 4 -- indent width
vo.softtabstop = 4 -- soft tab stop not tabs on tab/backspace
vo.expandtab = true -- use spaces instead of tabs
vo.smartindent = true -- smart auto-indent

vo.ignorecase = true -- case insensitive search
vo.smartcase = true -- case sensitive if uppercase present
vo.inccommand = "split" -- live preview of :s substitutions

vo.signcolumn = "yes"
vo.colorcolumn = "110"
vo.showmatch = true -- highlight matching brackets
vo.showmode = false
vo.pumheight = 10 -- popup menu height
vo.pumblend = 10 -- popup menu transparency
vo.winborder = "rounded" -- border for all floating windows
vo.synmaxcol = 300 -- syntax highlighting max limit

vo.splitright = true -- vertical splits open to the right
vo.splitbelow = true -- horizontal splits open below

vo.writebackup = false -- do not write to a backup file
vo.swapfile = false -- do not create a swapfile
vo.undofile = true -- persistent undo (stored in stdpath("state")/undo)
vo.updatetime = 300 -- faster CursorHold / diagnostics
vo.timeoutlen = 500 -- timeout duration
vo.ttimeoutlen = 0 -- key code timeout
vo.mouse = "a" -- enable mouse support in all modes

-- syncing the system clipboard can be slow, so do it after startup
vim.schedule(function()
	vo.clipboard = "unnamedplus"
end)

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Treat "-" as part of a word only where it is used in identifiers
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("DashKeyword", { clear = true }),
	pattern = { "css", "scss", "html", "yaml", "sh", "bash", "zsh" },
	callback = function()
		vim.opt_local.iskeyword:append("-")
	end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	group = vim.api.nvim_create_augroup("TerminalCleanup", { clear = true }),
	callback = function()
		if #vim.api.nvim_list_uis() > 0 then
			io.write("\27[0m\27[2J\27[H")
			io.flush()
		end
	end,
})
