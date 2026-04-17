local servers = { "lua_ls", "pyright", "ruff" }

local function real_config_dir()
	local config_dir = vim.fn.stdpath("config")
	return vim.uv.fs_realpath(config_dir) or config_dir
end

local ruff_fallback_config = vim.fs.normalize(vim.fs.joinpath(real_config_dir(), "..", "ruff", "ruff.toml"))
local ruff_root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" }
local ruff_config_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml" }

local function python_root_dir(bufnr)
	return vim.fs.root(bufnr, ruff_root_markers) or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
end

local function has_local_ruff_config(root_dir)
	if not root_dir then
		return false
	end

	for _, marker in ipairs(ruff_config_markers) do
		local path = vim.fs.joinpath(root_dir, marker)
		if vim.uv.fs_stat(path) then
			return true
		end
	end

	return false
end

local function ruff_enabled_for(bufnr)
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr, name = "ruff" })) do
		if not client:is_stopped() then
			return true
		end
	end

	return false
end

local function filter_pyright_diagnostics(bufnr, diagnostics)
	if not ruff_enabled_for(bufnr) then
		return diagnostics
	end

	return vim.tbl_filter(function(diagnostic)
		local missing_rule = diagnostic.code == nil or diagnostic.code == ""
		return not (diagnostic.severity == vim.diagnostic.severity.ERROR and missing_rule)
	end, diagnostics)
end

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

vim.lsp.config("pyright", {
	handlers = {
		["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
			if result and result.uri and result.diagnostics then
				local bufnr = vim.uri_to_bufnr(result.uri)
				result = vim.deepcopy(result)
				result.diagnostics = filter_pyright_diagnostics(bufnr, result.diagnostics)
			end

			return vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
		end,
	},
})

vim.lsp.config("ruff", {
	cmd = {
		"ruff",
		"server",
	},
	root_dir = function(bufnr, on_dir)
		on_dir(python_root_dir(bufnr))
	end,
	before_init = function(_, config)
		if has_local_ruff_config(config.root_dir) or not vim.uv.fs_stat(ruff_fallback_config) then
			config.init_options = nil
			return
		end

		config.init_options = {
			settings = {
				configuration = ruff_fallback_config,
				configurationPreference = "editorOnly",
			},
		}
	end,
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
})

for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end
