local servers = { "lua_ls", "pyright", "ruff" }
local ruff_config = vim.fs.normalize(vim.fs.joinpath(vim.fn.stdpath("config"), "..", "ruff", "ruff.toml"))

local function resolve_omnisharp_cmd()
	local bundled = vim.fn.expand("~/.local/share/omnisharp/OmniSharp")
	if vim.fn.executable(bundled) == 1 then
		return bundled
	end

	for _, candidate in ipairs({ "OmniSharp", "omnisharp" }) do
		if vim.fn.executable(candidate) == 1 then
			return candidate
		end
	end
end

local omnisharp_cmd = resolve_omnisharp_cmd()
if omnisharp_cmd then
	table.insert(servers, "omnisharp")
	vim.lsp.config("omnisharp", {
		cmd = { omnisharp_cmd, "--languageserver" },
		settings = {
			FormattingOptions = {
				EnableEditorConfigSupport = true,
			},
			RoslynExtensionsOptions = {
				EnableAnalyzersSupport = true,
			},
		},
	})
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

for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end
