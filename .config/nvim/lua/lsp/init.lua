local servers = { "lua_ls", "pyright", "omnisharp" }

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
