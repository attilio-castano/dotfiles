local M = {}

-- Only run checktime for normal, modifiable file buffers
local function maybe_checktime(buf)
    local bt = vim.bo[buf].buftype
    if bt == "" and vim.bo[buf].modifiable then
        pcall(vim.cmd, "silent! checktime")
    end
end

function M.setup()
    vim.opt.autoread = true

    -- Focus/buffer switches: catch external changes when returning or swapping buffers
    local grp = vim.api.nvim_create_augroup("AutoReloadOnFocus", { clear = true })
    vim.api.nvim_create_autocmd({ "FocusGained", "TermLeave", "TermClose", "BufEnter", "BufWinEnter" }, {
        group = grp,
        pattern = "*",
        desc = "Auto-reload changed files on focus/buffer switch",
        callback = function(args)
            maybe_checktime(args.buf)
        end,
    })

    -- Light idle checks: periodically verify on CursorHold/InsertHold with a small debounce
    local idle_grp = vim.api.nvim_create_augroup("AutoReloadIdle", { clear = true })
    local last = 0
    local min_interval = 800 -- ms between checks while idle
    local uv = vim.uv or vim.loop

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = idle_grp,
        pattern = "*",
        desc = "Auto-reload on idle (debounced checktime)",
        callback = function()
            local now = uv.now()
            if now - last < min_interval then
                return
            end
            last = now
            maybe_checktime(0)
        end,
    })
end

return M
