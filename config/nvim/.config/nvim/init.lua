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
-- Disable built-in line numbers to use custom statuscolumn
vim.opt.number         = false
vim.opt.relativenumber = false
vim.opt.signcolumn     = "yes:1"
vim.opt.numberwidth    = 5

-- Custom statuscolumn: [sign] [absolute] [relative] - but only for normal buffers
local function set_statuscolumn()
  local buftype = vim.bo.buftype
  local filetype = vim.bo.filetype
  local bufname = vim.api.nvim_buf_get_name(0)
  
  -- Don't show statuscolumn for special buffers
  if buftype == "" and 
     filetype ~= "NvimTree" and 
     filetype ~= "neo-tree" and
     not string.match(bufname, "NvimTree") then
    vim.opt_local.statuscolumn = '%s %{v:lnum} %{v:relnum}'
  else
    vim.opt_local.statuscolumn = ""
  end
end

vim.api.nvim_create_autocmd({"BufEnter", "FileType"}, {
  pattern = "*",
  callback = set_statuscolumn,
})
vim.opt.clipboard      = "unnamedplus"
vim.opt.updatetime     = 250
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
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

