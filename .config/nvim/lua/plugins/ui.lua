return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			component_separators = { left = "", right = "│" },
			sections = {
				lualine_c = {
					{
						"filename",
						path = 3,
						file_status = true,
						newfile_status = false,
					},
				},
			},
		},
	},

	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			css = true,
			mode = "background",
			names = false,
			RGB = true,
			RRGGBB = true,
			RRGGBBAA = true,
			rgb_fn = true,
			hsl_fn = true,
		},
	},
}
