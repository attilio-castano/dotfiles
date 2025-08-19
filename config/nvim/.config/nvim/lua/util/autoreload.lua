local M = {}

function M.setup()
    vim.opt.autoread = true

    local grp = vim.api.nvim_create_augroup("AutoReloadOnFocus", { clear = true })
    vim.api.nvim_create_autocmd({ "FocusGained", "TermLeave", "TermClose", "BufEnter", "BufWinEnter" }, {
        group = grp,
        pattern = "*",
        desc = "Auto-reload changed files on focus/buffer switch",
        callback = function(args)
            local bt = vim.bo[args.buf].buftype
            if bt == "" and vim.bo[args.buf].modifiable then
                pcall(vim.cmd, "silent! checktime")
            end
        end,
    })
end

return M

