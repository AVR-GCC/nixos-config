return function()
  local pane_id = require("check-ai-tab-open")()
  if pane_id ~= "" then
    vim.fn.system("tmux kill-pane -t " .. pane_id)
  end
end
