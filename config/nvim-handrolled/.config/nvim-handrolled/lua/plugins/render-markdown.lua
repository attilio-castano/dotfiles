return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons", -- for file type icons
        },
        opts = {
            -- Enable/disable rendering
            enabled = true,
            -- Maximum file size to render
            max_file_size = 10.0, -- MB
            -- File types to render
            file_types = { "markdown", "octo" },
            -- Render mode
            render_modes = { "n", "c" }, -- Normal and command mode
            -- Anti-conceal feature
            anti_conceal = {
                enabled = true,
            },
            -- Heading configuration
            heading = {
                enabled = true,
                sign = true,
                icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
            },
            -- Code block configuration
            code = {
                enabled = true,
                sign = true,
                style = "language",
                left_pad = 2,
                right_pad = 2,
                width = "full",
                language_pad = 2,
                border = "thin",
                above = "▄",
                below = "▀",
                highlight = "RenderMarkdownCode",
                highlight_inline = "RenderMarkdownCodeInline",
            },
            -- Dash (thematic break) configuration
            dash = {
                enabled = true,
                icon = "─",
                width = "full",
            },
            -- Bullet point configuration
            bullet = {
                enabled = true,
                icons = { "•", "∘", "▸", "▹" },
            },
            -- Checkbox configuration
            checkbox = {
                enabled = true,
                unchecked = {
                    icon = "󰄱 ",
                },
                checked = {
                    icon = "󰱒 ",
                },
            },
            -- Table configuration
            table = {
                enabled = true,
                style = "full",
            },
            -- Quote configuration
            quote = {
                enabled = true,
                icon = "▌",
            },
            -- Link configuration
            link = {
                enabled = true,
                image = "󰥶 ",
                email = "󰊫 ",
                hyperlink = "󰌹 ",
                highlight = "RenderMarkdownLink",
            },
        },
        config = function(_, opts)
            require("render-markdown").setup(opts)
        end,
    },
}