local M = {}

-- Returns true when the current Neovim instance is running inside the
-- Ghostty terminal emulator.  Ghostty sets $TERM to "xterm-ghostty" and
-- also exports $GHOSTTY_RESOURCES_DIR.  Either clue is enough.
M.active = vim.env.TERM == "xterm-ghostty" or vim.env.GHOSTTY_RESOURCES_DIR ~= nil

return M
