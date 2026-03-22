function()
  local current = vim.fn.bufnr()
  local buffers = vim.tbl_filter(function(buf)
    return buf.listed == 1 and vim.bo[buf.bufnr].buftype ~= "terminal"
  end, vim.fn.getbufinfo())
  local is_terminal = vim.bo.buftype == 'terminal'
  local is_empty = vim.fn.bufname() == '' and vim.fn.getbufvar(current, '&modified') == 0
  if is_empty and #buffers <= 1 then
    return
  elseif is_terminal then
    vim.cmd('wincmd k')
  elseif #buffers > 1 then
    local target
    for i, buf in ipairs(buffers) do
      if buf.bufnr == current then
        target = buffers[i - 1] or buffers[i + 1]
        break
      end
    end
    if target then
      vim.cmd("buffer " .. target.bufnr)
    else
      vim.cmd("enew")
    end
  else
    vim.cmd("enew")
  end
  vim.schedule(function()
    vim.cmd("bd! " .. current)
  end)
end
