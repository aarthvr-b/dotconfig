-- COLORSCHEME plugin

return {
    -- "vague-theme/vague.nvim",
    "metalelf0/base16-black-metal-scheme",
    lazy = false,
    priority = 1000,
    config = function()
        -- List of available variants
        local schemes = {
            -- "base16-black-metal-bathory",
            -- "base16-black-metal-burzum",
            -- "base16-black-metal-dark-funeral",
            "base16-black-metal-gorgoroth",
            -- "base16-black-metal-immortal",
            -- "base16-black-metal-khold",
            -- "base16-black-metal-marduk",
            -- "base16-black-metal-mayhem",
            -- "base16-black-metal-nile",
            -- "base16-black-metal-venom",
            -- "base16-black-metal",
        }

        local index = 1

        local function apply_scheme()
            vim.cmd.colorscheme(schemes[index])
            vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
            vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
            vim.notify("🎸 Black Metal Theme: " .. schemes[index], vim.log.levels.INFO)
        end

        apply_scheme()

        vim.keymap.set("n", "<leader>tc", function()
            index = index % #schemes + 1
            apply_scheme()
        end, { desc = " 🎨 Toggle Black Metal colorscheme" })
    end,
}
