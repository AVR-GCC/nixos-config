require('satellite').setup({
  current_only = false,
  winblend = 50,
  zindex = 40,
  excluded_filetypes = { "neo-tree", "NvimTree", "TelescopePrompt", "terminal", "toggleterm", "nofile" },
  width = 2,
  handlers = {
    cursor = { enable = true },
    diagnostic = {
      enable = true,
      signs = { "-", "=" },
      min_severity = vim.diagnostic.severity.HINT,
    },
    gitsigns = { enable = true },
    marks = { enable = false },
    quickfix = { enable = false },
    search = { enable = false },
  },
})
