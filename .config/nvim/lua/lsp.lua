
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Buffer local mappings. 
        -- See `:help vim.lsp.*` for docs


        local map = vim.keymap.set

        -- set keybinds
        map('n', "gR", "<cmd>Telescope lsp_references<CR>", { desc = 'Show LSP references'})
        map('n', "gD", "vim.lsp.buf.declaration", { desc = 'show declarations'})
        map('n', "gd", "vim.lsp.buf.definition", { desc = 'Show lsp definition'})
        map({'n','v'}, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions, in `v` mode it will apply to selection"})

        map.set("n", "[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, { desc  = "Go to previous diagnostic"} ) -- jump to previous diagnostic in buffer

        map.set("n", "]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, {desc = "Go to next diagnostic"}) -- jump to next diagnostic in buffer

        map.set("n", "K", vim.lsp.buf.hover, {desc = "Show documentation for what is under cursor" }) -- show documentation for what is under cursor

        map.set("n", "<leader>rs", ":LspRestart<CR>", {desc = "Restart LSP"} ) -- mapping to restart lsp if necessary
    end,
}
)

local severity = vim.diagnostic.severity

vim.diagnostic.config({
    -- virtual_text = true,
    -- alternatively show diag only for the current cursor line
    virtual_lines = {
        -- current_line = true,
    },
    signs = {
        text = {
            [severity.ERROR] = " ",
            [severity.WARN] = " ",
            [severity.HINT] = "󰠠 ",
            [severity.INFO] = " ",
        }
    }
})
