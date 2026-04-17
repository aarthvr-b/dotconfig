vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/catgoose/nvim-colorizer.lua" },
	{ src = "https://github.com/akinsho/bufferline.nvim" },
})

require("bufferline").setup({
	options = {
		numbers = "buffer_id",
		always_show_bufferline = true,
		separator_style = "slant",
	},
})

if vim.fn.has("nvim-0.11") == 1 then
	vim.tbl_flatten = function(t)
		return vim.iter(t):flatten(math.huge):totable()
	end
end

require("colorizer").setup(nil, {
	css = true,
	mode = "background",
	names = false,
	RGB = true,
	RRGGBB = true,
	RRGGBBAA = true,
	rgb_fn = true,
	hsl_fn = true,
})

require("lualine").setup({
	options = {
		component_separators = { left = "", right = "│" },
	},
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
})
