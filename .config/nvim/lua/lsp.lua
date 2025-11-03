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
