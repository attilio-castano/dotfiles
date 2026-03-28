local in_ghostty = vim.env.TERM == "xterm-ghostty" or vim.env.GHOSTTY_RESOURCES_DIR ~= nil

if not in_ghostty then
  return {}
end

return {
  {
    "folke/tokyonight.nvim",
    opts = function(_, opts)
      opts.transparent = true
      opts.styles = vim.tbl_deep_extend("force", opts.styles or {}, {
        floats = "transparent",
        sidebars = "transparent",
      })
    end,
  },
}
