require("extra-dapui")
require("extra-filetype")
require("extra-satellite")
vim.g.opencode_opts = { port = 4321 }
require("snippets")
require("luasnip.loaders.from_vscode").lazy_load()
