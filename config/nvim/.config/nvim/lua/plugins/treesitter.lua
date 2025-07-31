return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "bash", "python", "markdown", "vim" }, -- edit to taste
                highlight        = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent           = { enable = true },
            })
        end,
    },
}
