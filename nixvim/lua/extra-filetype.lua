vim.filetype.add({
  extension = {
    js = "javascriptreact",
    jsx = "javascriptreact",
    tsx = "typescriptreact",
  }
})
vim.treesitter.language.register("tsx", "javascriptreact")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascriptreact",
  callback = function()
    vim.treesitter.start()
  end,
})
