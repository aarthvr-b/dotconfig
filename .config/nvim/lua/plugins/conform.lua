return {
  'stevearc/conform.nvim',
  opts = {
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		cs = { "csharpier" },
	},
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback"
  }
  }

}
