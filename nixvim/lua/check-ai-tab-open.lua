return function()
  local source_pane = vim.fn.getenv("TMUX_PANE")
  -- Find an opencode pane tagged with our source pane ID
  local pane_id = vim.fn.system(
    "tmux list-panes -a -F '#{pane_id} #{pane_current_command} #{@source_pane}'"
    .. " | awk '$2 == \"opencode\" && $3 == \"" .. source_pane .. "\" {print $1; exit}'"
  ):gsub("%s+", "")
  return pane_id -- returns pane ID like "%5", or "" if none found
end
