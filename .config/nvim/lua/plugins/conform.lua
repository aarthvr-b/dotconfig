-- dotnet format is slow (spins up MSBuild), so C# formats async after save
local use_dotnet_format = vim.fn.executable("dotnet") == 1

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufWritePost" },
	cmd = "ConformInfo",
	opts = {
		formatters = {
			dotnet_format = {
				command = "dotnet",
				args = function(_, ctx)
					return { "format", "--include", ctx.filename, "--no-restore" }
				end,
				cwd = function(self, ctx)
					return require("conform.util").root_file({ "*.sln", "*.csproj" })(self, ctx)
				end,
				stdin = false,
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			cs = { use_dotnet_format and "dotnet_format" or "csharpier" },
		},
	},
}
