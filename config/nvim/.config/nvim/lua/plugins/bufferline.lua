return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    lazy = false,
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          numbers = "ordinal",           -- Show buffer numbers
          diagnostics = "nvim_lsp",
          separator_style = "thin",
          always_show_bufferline = true, -- Always show, even with 0-1 buffers
          show_buffer_close_icons = true, -- Show × on each buffer
          show_close_icon = false,       -- Hide global close icon
          modified_icon = "●",           -- Icon for modified buffers
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            }
          },
        },
      })
      -- Transparent background for Ghostty
      local in_ghostty = require("util.ghostty").active
      if in_ghostty then
        local hl = vim.api.nvim_set_hl
        hl(0, "BufferLineFill",             { bg = "none" })
        hl(0, "BufferLineBackground",       { bg = "none" })
        hl(0, "BufferLineBufferSelected",   { bg = "none", bold = true, italic = true })
        hl(0, "BufferLineBufferVisible",    { bg = "none" })
        hl(0, "BufferLineIndicatorSelected",{ bg = "none" })
        -- Additional selected buffer highlighting
        hl(0, "BufferLineNumbersSelected",   { fg = "#89b4fa", bold = true, bg = "none" })
        hl(0, "BufferLineModifiedSelected",  { fg = "#f38ba8", bold = true, bg = "none" })
      end
      -- Buffer navigation keymaps
      local map = vim.keymap.set
      local opts = { silent = true, noremap = true }
      map('n', '<A-,>', '<Cmd>BufferLineCyclePrev<CR>', opts)
      map('n', '<A-.>', '<Cmd>BufferLineCycleNext<CR>', opts)
      for i = 1, 9 do
        map('n', '<A-' .. i .. '>', '<Cmd>BufferLineGoToBuffer ' .. i .. '<CR>', opts)
      end
      map('n', '<leader>bp', '<Cmd>BufferLineCyclePrev<CR>', opts)
      map('n', '<leader>bn', '<Cmd>BufferLineCycleNext<CR>', opts)
      -- Buffer closing
      map('n', '<leader>bd', '<Cmd>bdelete<CR>', opts)
      map('n', '<leader>bD', '<Cmd>bdelete!<CR>', opts)
      map('n', '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', opts)
      -- Close all buffers and return to clean state (like nvim .)
      map('n', '<leader>ba', function()
        -- First ensure nvim-tree is open
        require('nvim-tree.api').tree.open()
        -- Then close all buffers (including any [No Name] buffers)
        vim.schedule(function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
              pcall(vim.cmd, 'bdelete ' .. buf)
            end
          end
        end)
      end, { silent = true, noremap = true, desc = "Close all buffers and show tree" })
      -- Force close all buffers and return to clean state
      map('n', '<leader>bA', function()
        -- First ensure nvim-tree is open
        require('nvim-tree.api').tree.open()
        -- Then force close all buffers
        vim.schedule(function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
              pcall(vim.cmd, 'bdelete! ' .. buf)
            end
          end
        end)
      end, { silent = true, noremap = true, desc = "Force close all buffers and show tree" })
    end,
  },
}