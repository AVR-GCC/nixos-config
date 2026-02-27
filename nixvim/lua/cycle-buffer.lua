return function(direction)
  local buffers = vim.tbl_filter(function(buf)
    return buf.listed == 1 and vim.bo[buf.bufnr].buftype ~= "terminal"
  end, vim.fn.getbufinfo())
  local current = vim.fn.bufnr()
  for i, buf in ipairs(buffers) do
    if buf.bufnr == current then
      local target
      if direction == "next" then
        target = buffers[i + 1] or buffers[1]
      else
        target = buffers[i - 1] or buffers[#buffers]
      end
      vim.cmd("buffer " .. target.bufnr)
      return
    end
  end
end
