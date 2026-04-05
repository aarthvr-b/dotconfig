local servers = { "lua_ls", "pyright" }

for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
