function(buf_number)
  return vim.bo[buf_number].buftype ~= "terminal"
end
