require("dapui").setup({
  layouts = {
    {
      elements = {
        { id = "watches",     size = 0.10 },
        { id = "breakpoints", size = 0.15 },
        { id = "stacks",      size = 0.30 },
        { id = "scopes",      size = 0.45 },
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        { id = "repl",    size = 0.5 },
        { id = "console", size = 0.5 },
      },
      size = 10,
      position = "bottom",
    },
  },
})
