vim.lsp.enable({
    "lua_ls",
    "pyright"
})

local severity = vim.diagnostic.severity

vim.diagnostic.config({
    virtual_text = { current_line = true },
    -- alternatively show diag only for the current cursor line
    -- virtual_lines = {
    --     current_line = true,
    -- },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        text = {
            [severity.ERROR] = " ",
            [severity.WARN] = " ",
            [severity.HINT] = "󰠠 ",
            [severity.INFO] = " ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        }
    }
})
