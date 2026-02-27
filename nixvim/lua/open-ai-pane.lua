return function()
  local cwd = vim.fn.getcwd()
  vim.fn.system("tmux split-window -h -l 25% -c '" .. cwd .. "' 'opencode'")
end
