function()
  local cwd = vim.fn.getcwd()
  local check = vim.fn.system("tmux list-panes -a -F '#{pane_current_command}' | grep -c opencode")
  check = check:gsub("%s+", "")
  if check ~= "0" then
    vim.fn.system("tmux list-panes -a -F '#{pane_id} #{pane_current_command}' | grep opencode | awk '{print $1}' | xargs tmux kill-pane -t")
  else
    vim.fn.system("tmux split-window -h -l 25% -c '" .. cwd .. "' 'opencode'")
  end
end
