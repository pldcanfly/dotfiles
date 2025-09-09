local langs = {
   "gopls",
   "lua_ls",
   "ts_ls",
   "docker_language_server",
   "docker_compose_language_service",
   "ansiblels",
   "bashls",
   "terraformls",
}

vim.lsp.enable(langs)

vim.diagnostic.config({
   virtual_text = true,
})
