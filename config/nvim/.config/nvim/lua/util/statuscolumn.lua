local M = {}

-- Format dual line numbers with stable alignment.
-- - Markdown: absolute only (relative column blank) to avoid wrap-induced lag.
-- - Other filetypes: absolute + buffer-relative numbers.
function M.dual()
  local lnum = vim.v.lnum or 0

  -- Width based on buffer line count; at least 2
  local total = vim.api.nvim_buf_line_count(0)
  local width = math.max(2, tostring(total):len())

  -- Absolute number
  local abs = string.format('%' .. width .. 'd', lnum)

  local ft = vim.bo.filetype
  if ft == 'markdown' then
    -- Absolute-only for markdown; do not pad a second column
    return abs
  end

  -- Buffer-relative for others
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
  local rel_val = math.abs(cursor_line - lnum)
  local rel_str
  if rel_val == 0 then
    rel_str = string.rep(' ', width)
  else
    rel_str = string.format('%' .. width .. 'd', rel_val)
  end

  return abs .. ' ' .. rel_str
end

return M
