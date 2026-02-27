return function()
  local check = vim.fn.system("tmux list-panes -a -F '#{pane_current_command}' | grep -c opencode")
  return check:gsub("%s+", "")
end
