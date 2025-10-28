return {
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
    opts = {
        autoinstall = false,
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
            "markdown",
            "luadoc",
            "lua",
            "python",
            "vim",
        }
    }
}
