local M = {}

function M.setup()
    -- Numbers & gutter defaults
    vim.opt.number         = true
    vim.opt.relativenumber = true
    vim.opt.signcolumn     = "auto:1"
    vim.opt.numberwidth    = 5

    -- Clipboard, timing, indent
    -- Prefer system clipboard ('+'); fall back to X selection ('*') when '+''s provider is unavailable
    vim.opt.clipboard  = "unnamed,unnamedplus"
    vim.opt.updatetime = 250
    vim.opt.shiftwidth = 4
    vim.opt.tabstop    = 4
    vim.opt.expandtab  = true
end

return M
