return {
  "luukvbaal/statuscol.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWinEnter" },
  config = function()
    local statuscol = require("statuscol")
    local builtin = require("statuscol.builtin")

    -- Use our dual number formatter (absolute | relative)
    local function dualnum()
      return require("util.statuscolumn").dual()
    end

    statuscol.setup({
      -- Keep things minimal: no extra separators or padding
      separator = "",
      setopt = true,  -- Have the plugin set the global 'statuscolumn'
      relculright = false,
      segments = {
        -- Signs column (diagnostics/gitsigns). Compact and only visible when needed.
        { text = { "%s" }, click = "v:lua.ScSa" },
        -- Dual numbers with stable alignment
        { text = { dualnum }, click = "v:lua.ScLa" },
        -- Fold column – show only when folds exist; otherwise stays slim
        { text = { " ", builtin.foldfunc }, click = "v:lua.ScFa" },
      },
    })

    -- Hide statuscolumn entirely in special buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "NvimTree", "neo-tree", "help", "dashboard" },
      callback = function()
        vim.opt_local.statuscolumn = ""
        vim.opt_local.signcolumn = "no"
      end,
    })

    -- Debounced refresh on movement/scroll
    local pending = false
    local function schedule_refresh()
      if pending then return end
      pending = true
      vim.defer_fn(function()
        pending = false
        vim.cmd("redrawstatus")
      end, 15)
    end

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "WinScrolled" }, {
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if ft == "NvimTree" or ft == "neo-tree" or ft == "help" or ft == "dashboard" then
          return
        end
        schedule_refresh()
      end,
      desc = "statuscol: refresh on move/scroll",
    })

  end,
}
