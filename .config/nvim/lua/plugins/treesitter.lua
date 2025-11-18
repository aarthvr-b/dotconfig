return {
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
    opts = {
        autoinstall = true,
        highlight = { enable = true },
        indent = { enable = true },
    }
}
