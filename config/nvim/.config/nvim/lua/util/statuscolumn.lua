local M = {}

-- Format dual line numbers with stable alignment using Neovim's native engine.
-- - Markdown: absolute only (relative column omitted).
-- - Others: absolute (args.lnum) + relative (args.relnum, blank on current line).
function M.dual(args)
  args = args or {}
  local lnum = args.lnum or vim.v.lnum or 0
  local rel  = args.relnum or vim.v.relnum or 0
  local width = args.nuw or vim.o.numberwidth or 4

  local abs = string.format('%' .. width .. 'd', lnum)

  local ft = vim.bo.filetype
  if ft == 'markdown' then
    return abs
  end

  local rel_str
  if rel == 0 then
    rel_str = string.rep(' ', width)
  else
    rel_str = string.format('%' .. width .. 'd', rel)
  end

  return abs .. ' ' .. rel_str
end

return M
