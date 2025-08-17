return {
  "luukvbaal/statuscol.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWinEnter" },
  config = function()
    local statuscol = require("statuscol")
    local builtin = require("statuscol.builtin")

    -- Use our dual number formatter (reads args.lnum/args.relnum from native engine)
    local function dualnum(args)
      return require("util.statuscolumn").dual(args)
    end

    statuscol.setup({
      -- Keep things minimal: no extra separators or padding
      separator = "",
      setopt = true,  -- Have the plugin set the global 'statuscolumn'
      relculright = false,
      segments = {
        -- Signs column (diagnostics/gitsigns). Renders via built-in %s; width capped by signcolumn option.
        { text = { "%s" }, click = "v:lua.ScSa" },
        -- Dual numbers with stable alignment
        { text = { dualnum }, click = "v:lua.ScLa" },
        -- Fold column – no extra spacer, just folds
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
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

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "WinScrolled", "TextChanged", "TextChangedI", "DiagnosticChanged" }, {
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if ft == "NvimTree" or ft == "neo-tree" or ft == "help" or ft == "dashboard" then
          return
        end
        schedule_refresh()
      end,
      desc = "statuscol: refresh on move/scroll/edit/diagnostics",
    })

    -- Refresh on layout-affecting option changes
    vim.api.nvim_create_autocmd("OptionSet", {
      pattern = { "wrap", "linebreak", "breakindent", "showbreak", "conceallevel", "spell" },
      callback = function(args)
        local buf = args and args.buf or 0
        local ft = (buf ~= 0) and vim.bo[buf].filetype or vim.bo.filetype
        if ft == "NvimTree" or ft == "neo-tree" or ft == "help" or ft == "dashboard" then
          return
        end
        schedule_refresh()
      end,
      desc = "statuscol: refresh on wrap/conceal/spell option changes",
    })

    -- Refresh on window resize (reflows wrapped text)
    vim.api.nvim_create_autocmd("VimResized", {
      callback = function()
        schedule_refresh()
      end,
      desc = "statuscol: refresh on resize",
    })

    -- Refresh when gitsigns updates the gutter
    vim.api.nvim_create_autocmd("User", {
      pattern = { "GitsignsUpdate", "GitSignsUpdate" },
      callback = function()
        schedule_refresh()
      end,
      desc = "statuscol: refresh on gitsigns update",
    })

  end,
}
