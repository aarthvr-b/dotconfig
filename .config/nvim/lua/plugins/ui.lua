vim.pack.add({
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
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
