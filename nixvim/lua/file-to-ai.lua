return function(pane_id)
  local filepath = vim.fn.expand("%")
  local path = string.format("@%s", filepath)
  for i = 1, #path do
    local char = path:sub(i, i)
    os.execute("tmux send-keys -t " .. pane_id .. " -l '" .. char:gsub("'", "'\\''") .. "'")
    vim.loop.sleep(1)
  end
  vim.loop.sleep(120)
  os.execute("tmux send-keys -t " .. pane_id .. " Enter")
end
