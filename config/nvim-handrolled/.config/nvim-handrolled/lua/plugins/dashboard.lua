-- Dashboard configuration
-- Beautiful startup screen with recent files and shortcuts

return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { 
        "nvim-tree/nvim-web-devicons",
        "MaximilianLloyd/ascii.nvim",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        local ascii = require("ascii")
        -- Debug: print available text art
        -- vim.notify(vim.inspect(ascii.art.text))
        require("dashboard").setup({
            theme = "doom",
            config = {
                header = ascii.art.text.neovim.sharp,
                center = {
                    {
                        icon = " ",
                        icon_hl = "Title",
                        desc = "Find File",
                        desc_hl = "String",
                        key = "f",
                        keymap = "SPC f f",
                        key_hl = "Number",
                        key_format = " %s", -- remove default surrounding brackets
                        action = "Telescope find_files",
                    },
                    {
                        icon = " ",
                        icon_hl = "Title",
                        desc = "Recent Files",
                        desc_hl = "String",
                        key = "r",
                        keymap = "SPC f r",
                        key_hl = "Number",
                        key_format = " %s",
                        action = "Telescope oldfiles",
                    },
                    {
                        icon = " ",
                        icon_hl = "Title",
                        desc = "Find Word",
                        desc_hl = "String",
                        key = "g",
                        keymap = "SPC f g",
                        key_hl = "Number",
                        key_format = " %s",
                        action = "Telescope live_grep",
                    },
                    {
                        icon = " ",
                        icon_hl = "Title",
                        desc = "New File",
                        desc_hl = "String",
                        key = "n",
                        keymap = "SPC f n",
                        key_hl = "Number",
                        key_format = " %s",
                        action = "enew",
                    },
                    {
                        icon = " ",
                        icon_hl = "Title",
                        desc = "Config",
                        desc_hl = "String",
                        key = "c",
                        keymap = "SPC f c",
                        key_hl = "Number",
                        key_format = " %s",
                        action = "edit ~/.config/nvim/init.lua",
                    },
                    {
                        icon = " ",
                        icon_hl = "Title",
                        desc = "Lazy",
                        desc_hl = "String",
                        key = "l",
                        keymap = "SPC l",
                        key_hl = "Number",
                        key_format = " %s",
                        action = "Lazy",
                    },
                    {
                        icon = " ",
                        icon_hl = "Title",
                        desc = "Quit",
                        desc_hl = "String",
                        key = "q",
                        keymap = "q",
                        key_hl = "Number",
                        key_format = " %s",
                        action = "quit",
                    },
                },
                footer = {}, -- you can add a footer message here
            },
        })
    end,
}