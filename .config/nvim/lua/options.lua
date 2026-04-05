local vo = vim.opt

vo.number = true -- line number
vo.relativenumber = true -- relative line numbers
vo.cursorline = true -- highlight current line
vo.wrap = false -- do now wrap lines
vo.scrolloff = 10 -- keep 10 lines above/below cursor
vo.sidescrolloff = 10 -- keep 10 horizonally

vo.tabstop = 4 -- tab width
vo.shiftwidth = 4 -- indent width
vo.softtabstop = 4 -- soft tab stop not tabs on tab/backspace
vo.expandtab = true -- use spaces intead of tabs
vo.smartindent = true -- smart auto-indent
vo.autoindent = true -- copy indent from current line

vo.ignorecase = true -- case insensitive search
vo.smartcase = true -- case sensitive if uppercase present
vo.hlsearch = true -- highlight search matches
vo.incsearch = true -- show matches as you type

vo.signcolumn = "yes"
vo.colorcolumn = "110"
vo.showmatch = true --highlight matching brackets
vo.cmdheight = 1
vo.completeopt = "menuone,noinsert,noselect"
vo.showmode = false
vo.pumheight = 10 -- popup menu height
vo.pumblend = 10 -- popup menu tansparency
vo.winblend = 0 -- floating window transparency
vo.conceallevel = 0 -- do not hide markup
vo.concealcursor = ""
vo.synmaxcol = 300 -- syntax highlighting max limit

local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false -- do not create a swapfile
vim.opt.undofile = true -- do create an undo file
vim.opt.undodir = undodir -- set the undo directory
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 -- timeout duration
vim.opt.ttimeoutlen = 0 -- key code timeout
vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto-save

vim.opt.hidden = true -- allow hidden buffers
vim.opt.backspace = "indent,eol,start" -- better backspace behaviour
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append("-") -- include - in words
vim.opt.path:append("**") -- include subdirs in search
vim.opt.selection = "inclusive" -- include last char in selection
vim.opt.mouse = "a" -- enable mouse support
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
vim.opt.modifiable = true -- allow buffer modifications
vim.opt.encoding = "utf-8" -- set encoding

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	-- alternatively show diag only for the current cursor line
	-- virtual_lines = {
	--     current_line = true,
	-- },
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		syle = "minimal",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "󰠠",
			[vim.diagnostic.severity.INFO] = "",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})
