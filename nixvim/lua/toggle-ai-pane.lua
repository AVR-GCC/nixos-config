function()
  local check = require("check-ai-tab-open")()
  if check == "" then
    require("open-ai-pane")()
  else
    require("close-ai-pane")()
  end
end
