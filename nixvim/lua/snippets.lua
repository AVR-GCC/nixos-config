local ls = require "luasnip"
local a = ls.add_snippets
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local pr = s("pr", {
  t('println!("'),
  i(1),
  t(': {:?}", );')
})

local log = s("log", {
  t('console.log('),
  i(1),
  t(');')
})

local logg = s("logg", {
  t("console.log('"),
  f(function() return vim.fn.getreg("+") end, {}),
  t("', "),
  f(function() return vim.fn.getreg("+") end, {}),
  t(");"),
})

a("all", { pr })
a("typescript", { log, logg })
a("typescriptreact", { log, logg })

-- Enable snippet expansion with a keybinding
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })
