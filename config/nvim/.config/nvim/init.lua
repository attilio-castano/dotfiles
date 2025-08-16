-- init.lua ------------------------------------------------------------
-- Author: Attilio 
-- Clean, minimal, Ghostty‑aware Neovim config
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- 0. Leader / globals
-----------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

-----------------------------------------------------------------------
-- 1. Terminal / GUI settings
-----------------------------------------------------------------------
local in_ghostty = require("util.ghostty").active

vim.opt.termguicolors = true
vim.opt.background   = "dark"

-- Note: Transparent backgrounds are handled by Catppuccin in colorscheme.lua
-- We only set diagnostic undercurls here for better visibility
if in_ghostty then
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff5c5c" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = "#f0e130" })
end

-----------------------------------------------------------------------
-- 2. Editor behaviour tweaks (feel free to extend)
-----------------------------------------------------------------------
-- Enable native number engine; statuscol.nvim will render via statuscolumn
vim.opt.number         = true
vim.opt.relativenumber = true
-- Slim gutter: let signs appear only when needed
-- Cap signs to a single column when present
vim.opt.signcolumn     = "auto:1"
vim.opt.numberwidth    = 5

-- Status column is handled by statuscol.nvim (see plugins/statuscol.lua)
vim.opt.clipboard      = "unnamedplus"
vim.opt.updatetime     = 250
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- Auto-reload files changed outside of Neovim
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "TermLeave", "TermClose", "BufEnter", "BufWinEnter" }, {
  pattern = "*",
  desc = "Auto-reload changed files on focus/buffer switch",
  callback = function(args)
    local bt = vim.bo[args.buf].buftype
    if bt == "" and vim.bo[args.buf].modifiable then
      pcall(vim.cmd, "silent! checktime")
    end
  end,
})

-- Dynamic numberwidth: adapt to buffer line count (2..4)
local function update_numberwidth()
  local total = vim.api.nvim_buf_line_count(0)
  local digits = tostring(total):len()
  local width = math.max(2, math.min(4, digits))
  vim.opt_local.numberwidth = width
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufReadPost", "BufWritePost", "VimResized" }, {
  pattern = "*",
  desc = "Adjust numberwidth per window based on line count",
  callback = function()
    pcall(update_numberwidth)
  end,
})
-----------------------------------------------------------------------
-- 3. Bootstrap lazy.nvim
-----------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--depth=1",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- ---------------------------------------------------------------------
-- 4. Plugins ----------------------------------------------------------
-- ---------------------------------------------------------------------
require("lazy").setup({
  -- Colourscheme – load first so subsequent plugins can link highlight groups
  require("plugins.colorscheme"),

  -- Core plugins
  require("plugins.treesitter"),
  require("plugins.nvimtree"),
  require("plugins.gitsigns"),    -- git diff signs & hunk actions
  require("plugins.diffview"),    -- Git diff viewer (VS Code-like)
  require("plugins.neogit"),      -- Magit-inspired git interface
  require("plugins.octo"),        -- GitHub integration (PRs, issues, reviews)
  require("plugins.lspconfig"),   -- Language Server Protocol (LSP) config for Python (Pyright & Ruff)

  -- UI enhancements
  require("plugins.indent-blankline"), -- indent guides
  require("plugins.lualine"),     -- statusline
  require("plugins.bufferline"),  -- buffer/tabline
  require("plugins.statuscol"),   -- compact gutter (signs, folds, dual numbers)
  require("plugins.whichkey"),    -- keybinding hints
  require("plugins.telescope"),   -- fuzzy finder
  require("plugins.render-markdown"), -- beautiful markdown rendering in terminal
  require("plugins.dashboard"),   -- startup screen with recent files
  require("plugins.ascii"),       -- ASCII art collection
  -- Add more plugins here
})

-----------------------------------------------------------------------
-- 5. Extra keymaps ----------------------------------------------------
-----------------------------------------------------------------------
local map = vim.keymap.set
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
-- Fast window navigation with Alt+h/j/k/l
map("n", "<A-h>", "<C-w>h", { desc = "Move to window on the left" })
map("n", "<A-j>", "<C-w>j", { desc = "Move to window below" })
map("n", "<A-k>", "<C-w>k", { desc = "Move to window above" })
map("n", "<A-l>", "<C-w>l", { desc = "Move to window on the right" })
-- Toggle markdown rendering
map("n", "<leader>m", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle markdown rendering" })
-- Split creation keybindings
map("n", "<leader>h", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "Split vertical" })
-- Clipboard yank keybindings
map("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
