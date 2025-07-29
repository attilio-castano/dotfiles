return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = function()
      -- indent-blankline ≥3 uses the new `ibl` module name
      require("ibl").setup({
        indent = { char = "│" },
        whitespace = { remove_blankline_trail = false },
        exclude = {
          filetypes = {
            "help",
            "dashboard",
            "lazy",
            "NvimTree",
            "man",
            "lsp-installer",
            "packer",
          },
          buftypes = { "terminal", "nofile" },
        },
      })
    end,
  },
}