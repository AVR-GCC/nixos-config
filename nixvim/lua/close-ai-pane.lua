return function()
  vim.fn.system("tmux list-panes -a -F '#{pane_id} #{pane_current_command}' | grep opencode | awk '{print $1}' | xargs tmux kill-pane -t")
end
