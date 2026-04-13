local servers = { "lua_ls", "pyright", "omnisharp", "ruff" }
local ruff_config = vim.fn.expand("~/dotconfig/.config/ruff/ruff.toml")

for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end

vim.lsp.config("omnisharp", {
	cmd = { vim.fn.expand("~/.local/share/omnisharp/OmniSharp"), "--languageserver" },
	settings = {
		FormattingOptions = {
			EnableEditorConfigSupport = true,
		},
		RoslynExtensionsOptions = {
			EnableAnalyzersSupport = true,
		},
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.config("ruff", {
	cmd = {
		"ruff",
		"server",
	},
	root_dir = function(bufnr, on_dir)
		on_dir(vim.fs.root(bufnr, { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" })
			or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)))
	end,
	init_options = {
		settings = {
			configuration = ruff_config,
			configurationPreference = "editorOnly",
		},
	},
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
})
