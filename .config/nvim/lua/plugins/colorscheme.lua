-- COLORSCHEME plugin

return {
    "vague-theme/vague.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        opts = {
            transparent = true
        }
        vim.cmd("colorscheme vague")
    end,
}
