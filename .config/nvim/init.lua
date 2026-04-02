vim.opt.termguicolors = true
vim.cmd.colorscheme("habamax")

-- ============
-- OPTIONS
-- ===========
require("options")


-- ============
-- KEYMAPS
-- ===========
require("keymaps")

-- ============
-- PLUGINS
-- ===========
vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    'https://github.com/neovim/nvim-lspconfig',
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lualine/lualine.nvim",
    'https://github.com/dmtrKovalenko/fff.nvim',
    "https://github.com/christoomey/vim-tmux-navigator"
})

-- fff config
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(event)
        if event.data.updated then
            require('fff.download').download_or_build_binary()
        end
    end,
})
-- the plugin will automatically lazy load
vim.g.fff = {
    lazy_sync = true, -- start syncing only when the picker is open
    debug = {
        enabled = true,
        show_scores = true,
    },
}


require("lualine").setup({
    options = {
        component_separators = { left = '', right = '│' },
    }
}
)

require("gitsigns").setup({
    signs = {
        add = { text = "\u{2590}" },    -- ▏
        change = { text = "\u{2590}" }, -- ▐
        delete = { text = "\u{2590}" }, -- ◦
        topdelete = { text = "\u{25e6}" }, -- ◦
        changedelete = { text = "\u{25cf}" }, -- ●
        untracked = { text = "\u{25cb}" }, -- ○
    },
    signcolumn = true,
    current_line_blame = false,
})

require("oil").setup({
    view_options = {
        show_hidden = true
    }
})

-- ============
-- LSPs
-- ===========
local servers = { "lua_ls", "pyright" }

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

-- setting `vim` as a global variable
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
}
)
