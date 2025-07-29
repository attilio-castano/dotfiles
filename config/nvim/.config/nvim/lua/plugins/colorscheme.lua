-- lua/plugins/colorscheme.lua
-- Catppuccin colour scheme with full Treesitter + LSP semantic-token support

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,           -- load during startup so it can set highlight groups early
    priority = 1000,        -- load before all other plugins that might set colours
    config = function()
      require("catppuccin").setup {
        flavour = "mocha",  -- latte, frappe, macchiato, mocha
        transparent_background = true, -- Normal/NormalFloat will be set to none in init.lua when in Ghostty

        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors       = { "undercurl" },
              hints        = { "undercurl" },
              warnings     = { "undercurl" },
              information  = { "undercurl" },
            },
          },
          gitsigns = true,
          telescope = true,
          nvimtree = true,
          which_key = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
        },
      }

      -- Apply the colourscheme now that it's guaranteed to be available.
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
