-- ~/.config/nvim/lua/plugins/telescope_ignore.lua
local M = {}

-- Patterns passed straight into `telescope.setup.defaults.file_ignore_patterns`
M.file_ignore_patterns = {
  -- Python artifacts
  "__pycache__",
  "%.pyc$",
  "%.pyo$",
  -- virtualenvs
  ".venv",
  "venv",
  -- Node / front-end
  "node_modules",
  -- Git / VCS
  "%.git/",
  -- build outputs
  "dist",
  "build",
  "target",
  -- macOS Finder
  "%.DS_Store$",
  -- caches, logs, etc
  ".cache",
  "%.log$",
}

return M
