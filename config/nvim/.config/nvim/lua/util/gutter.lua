local M = {}

local function update_numberwidth()
    local total  = vim.api.nvim_buf_line_count(0)
    local digits = tostring(total):len()
    local width  = math.max(2, math.min(4, digits))
    vim.opt_local.numberwidth = width
end

function M.setup()
    local grp = vim.api.nvim_create_augroup("DynamicNumberWidth", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufReadPost", "BufWritePost", "VimResized" }, {
        group = grp,
        pattern = "*",
        desc = "Adjust numberwidth per window based on line count",
        callback = function()
            pcall(update_numberwidth)
        end,
    })
end

return M

