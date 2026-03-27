function()
  local pane_id = require("confirm-ai-tab-open")()
  require("file-to-ai")(pane_id)

  local lnum = vim.fn.line('.') - 1
  local diags = vim.diagnostic.get(0, { lnum = lnum })

  if #diags == 0 then
    vim.notify("No diagnostics on current line", vim.log.levels.WARN)
    return
  end

  local diag = diags[1]
  local severity = vim.diagnostic.severity[diag.severity]
  local line_content = vim.api.nvim_buf_get_lines(0, lnum, lnum + 1, false)[1] or ""

  local message = string.format(
    "%s diagnostic - line %d:\n\n```\n%s\n```\n\nError: %s\n\nSource: %s",
    severity,
    lnum + 1,
    line_content:match("^%s*(.-)%s*$"),
    diag.message,
    diag.source or "unknown"
  )

  -- Escape the message for shell
  local escaped = message:gsub("'", "'\\''")
  local cmd = string.format("tmux send-keys -t %s '%s' Enter", pane_id, escaped)
  vim.fn.system(cmd)
end
