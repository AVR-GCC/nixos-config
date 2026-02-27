function()
  local check = require("check-ai-tab-open")()
  if check ~= "0" then
    require("close-ai-pane")()
  else
    require("open-ai-pane")()
  end
end
