local M = {}

-- Format dual line numbers with stable alignment using Neovim's native engine.
-- Absolute: args.lnum; Relative: args.relnum (blank on current line).
function M.dual(args)
  args = args or {}
  local lnum = args.lnum or vim.v.lnum or 0
  local rel  = args.relnum or vim.v.relnum or 0
  local width = args.nuw or vim.o.numberwidth or 4

  local abs = string.format('%' .. width .. 'd', lnum)

  local rel_str
  if rel == 0 then
    rel_str = string.rep(' ', width)
  else
    rel_str = string.format('%' .. width .. 'd', rel)
  end

  return abs .. ' ' .. rel_str
end

return M
