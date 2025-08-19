local M = {}

function M.setup()
    -- General terminal/GUI defaults
    vim.opt.termguicolors = true
    vim.opt.background    = "dark"

    -- Note: Transparent backgrounds are handled by Catppuccin in colorscheme.lua
    -- Apply subtle diagnostic undercurls when running inside Ghostty
    local in_ghostty = require("util.ghostty").active
    if in_ghostty then
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff5c5c" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = "#f0e130" })
    end
end

return M

