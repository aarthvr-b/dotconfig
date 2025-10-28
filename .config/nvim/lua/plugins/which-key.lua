-- Which-key
-- plugin to help with shortcuts

return {
    "folke/which-key.nvim",
    dependencies = {
        "https://github.com/nvim-mini/mini.icons",
        "https://github.com/nvim-tree/nvim-web-devicons"
    },
    event = "VeryLazy",
    opts = {},
    keys = {
        {
            "<leader>?",
            function()
                require('which-key').show( {global = false})
            end, desc = "Buffer Local Keymaps (which-key)",
        }
    }
}
