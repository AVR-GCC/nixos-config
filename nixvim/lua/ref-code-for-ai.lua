function()
  vim.cmd('normal! "+y')

  local filepath = vim.fn.expand("%")

  if vim.bo.buftype == "terminal" then
    os.execute("tmux send-keys -t ':.+1' -l 'term: '")
  else
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line = start_pos[2]
    local end_line = end_pos[2]

    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end

    local path = string.format("@%s", filepath)
    local line_numbers = string.format(":%d-%d", start_line, end_line)

    for i = 1, #path do
      local char = path:sub(i, i)
      os.execute("tmux send-keys -t ':.+1' -l '" .. char:gsub("'", "'\\''") .. "'")
      vim.loop.sleep(1)
    end
    vim.loop.sleep(120)
    os.execute("tmux send-keys -t ':.+1' Enter")
    os.execute("tmux send-keys -t ':.+1' -l '" .. line_numbers:gsub("'", "'\\''") .. "'")
    os.execute("tmux send-keys -t ':.+1' C-j")
  end

  os.execute("tmux load-buffer -b opencode - <<< \"$(xclip -selection clipboard -o)\"")
  os.execute("tmux paste-buffer -p -t ':.+1' -b opencode")
  os.execute("tmux send-keys -t ':.+1' C-j")
  os.execute("tmux select-pane -t ':.+1'")
end
