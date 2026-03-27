return function()
  local pane_id = require("check-ai-tab-open")()
  if pane_id == "" then
    require("open-ai-pane")()
    vim.loop.sleep(3500)
    -- Re-fetch the pane ID after opening
    pane_id = require("check-ai-tab-open")()
  end
  return pane_id
end
