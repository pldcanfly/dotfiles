local langs = { "gopls", "lua_ls", "ts_ls" }

vim.lsp.enable(langs)

vim.diagnostic.config({
   virtual_text = true,
})
