function()
  vim.cmd("botright " .. math.floor(vim.o.lines * 0.3) .. "split")
  vim.cmd("terminal")
  vim.defer_fn(function()
    vim.cmd("startinsert")
  end, 1)
end
