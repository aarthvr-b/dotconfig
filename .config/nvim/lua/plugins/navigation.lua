return {
	{
		"stevearc/oil.nvim",
		opts = { view_options = { show_hidden = true } },
		keys = {
			{ "<leader>pv", "<cmd>Oil<cr>", desc = "Open [P]arent directory [V]iew" },
		},
	},

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bufdelete = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
		},
		keys = {
			{
				"<leader>pf",
				function()
					Snacks.picker.files()
				end,
				desc = "Find files",
			},
			{
				"<leader>ps",
				function()
					Snacks.picker.grep()
				end,
				desc = "Search with grep",
			},
			{
				"<leader>pb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>pr",
				function()
					Snacks.picker.recent()
				end,
				desc = "Recent files",
			},
			{
				"<leader>ph",
				function()
					Snacks.picker.help()
				end,
				desc = "Help pages",
			},
			{
				"<leader>pd",
				function()
					Snacks.picker.diagnostics_buffer()
				end,
				desc = "Buffer diagnostics",
			},
			{
				"<leader>pD",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Workspace diagnostics",
			},
			{
				"<leader>po",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "Document symbols",
			},
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete buffer (keep window)",
			},
		},
	},
}
