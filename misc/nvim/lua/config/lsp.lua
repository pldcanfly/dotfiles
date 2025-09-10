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
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

vim.lsp.enable(langs)

vim.diagnostic.config({
   virtual_text = true,
})
