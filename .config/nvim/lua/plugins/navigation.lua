vim.pack.add({
    { src = "https://github.com/dmtrKovalenko/fff.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
})

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(event)
        if event.data.updated then
            require("fff.download").download_or_build_binary()
        end
    end,
})

vim.g.fff = {
    lazy_sync = true,
    debug = {
        enabled = true,
        show_scores = true,
    },
}

require("oil").setup({
    view_options = {
        show_hidden = true,
    },
    keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
    },
})
