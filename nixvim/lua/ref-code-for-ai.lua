function()
  local pane_id = require("check-ai-tab-open")()
  if pane_id == "" then
    require("open-ai-pane")()
    vim.loop.sleep(2500)
    -- Re-fetch the pane ID after opening
    pane_id = require("check-ai-tab-open")()
  end
  vim.cmd('normal! "+y')

  local filepath = vim.fn.expand("%")

  if vim.bo.buftype == "terminal" then
    os.execute("tmux send-keys -t " .. pane_id .. " -l 'term: '")
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
      os.execute("tmux send-keys -t " .. pane_id .. " -l '" .. char:gsub("'", "'\\''") .. "'")
      vim.loop.sleep(1)
    end
    vim.loop.sleep(120)
    os.execute("tmux send-keys -t " .. pane_id .. " Enter")
    os.execute("tmux send-keys -t " .. pane_id .. " -l '" .. line_numbers:gsub("'", "'\\''") .. "'")
    os.execute("tmux send-keys -t " .. pane_id .. " C-j")
  end

  os.execute("tmux load-buffer -b opencode - <<< \"$(xclip -selection clipboard -o)\"")
  os.execute("tmux paste-buffer -p -t " .. pane_id .. " -b opencode")
  os.execute("tmux send-keys -t " .. pane_id .. " C-j")
  os.execute("tmux select-pane -t " .. pane_id)
end
