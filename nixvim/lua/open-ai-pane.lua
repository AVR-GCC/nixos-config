return function()
  local cwd = vim.fn.getcwd()
  local source_pane = vim.fn.getenv("TMUX_PANE")
  -- Split and capture the new pane's ID, then tag it with our source pane
  local new_pane = vim.fn.system(
    "tmux split-window -h -l 25% -c '" .. cwd .. "' -P -F '#{pane_id}' 'opencode'"
  ):gsub("%s+", "")
  vim.fn.system("tmux set-option -p -t " .. new_pane .. " @source_pane " .. source_pane)
end
