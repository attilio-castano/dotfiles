return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("gitsigns").setup {
        signs = {
          add          = { text = "+" },
          change       = { text = "~" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          -- Navigation
          map('n', ']c', function() if vim.wo.diff then return ']c' end; vim.schedule(gs.next_hunk) end, 'Next Hunk')
          map('n', '[c', function() if vim.wo.diff then return '[c' end; vim.schedule(gs.prev_hunk) end, 'Prev Hunk')
          -- Actions
          map('n', '<leader>gs', gs.stage_hunk,           'Stage Hunk')
          map('n', '<leader>gr', gs.reset_hunk,           'Reset Hunk')
          map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line('.') , vim.fn.line('v') } end, 'Stage Hunk')
          map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.') , vim.fn.line('v') } end, 'Reset Hunk')
          map('n', '<leader>gS', gs.stage_buffer,         'Stage Buffer')
          map('n', '<leader>gR', gs.reset_buffer,         'Reset Buffer')
          map('n', '<leader>gp', gs.preview_hunk,         'Preview Hunk')
          map('n', '<leader>gb', function() gs.blame_line { full = true } end, 'Blame Line')
        end,
      }
    end,
  },
}