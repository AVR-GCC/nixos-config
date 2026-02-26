function()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })
  local is_terminal = vim.bo.buftype == 'terminal'
  local is_empty = vim.fn.bufname() == '' and vim.fn.getbufvar(vim.fn.bufnr(), '&modified') == 0
  if is_empty and #buffers <= 1 then
    return
  elseif #buffers > 1 then
    vim.cmd('bp | bd! #')
  else
    vim.cmd('enew | bd! #')
  end
  if is_terminal then
    vim.cmd('close')
  end
end
