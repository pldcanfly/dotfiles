local companion = require("schema-companion")

---@type vim.lsp.Config
return companion.setup_client(
   companion.adapters.yamlls.setup({
      sources = {
         -- multi-document aware replacement for companion.sources.matchers.kubernetes,
         -- see lua/config/k8s_schema.lua
         require("config.k8s_schema").setup({ version = "v1.33.0" }),
         companion.sources.lsp.setup(),
      },
   }),
   {
      cmd = { "yaml-language-server", "--stdio" },
      filetypes = { "yaml", "yaml.gitlab", "yaml.docker-compose" },
      root_markers = { ".git" },
      on_init = function(client)
         -- keep lspconfig's formatting-capability fix, which this file now overrides
         client.server_capabilities.documentFormattingProvider = true
      end,
      settings = {
         yaml = {
            validate = true,
            hover = true,
            completion = true,
            schemaStore = { enable = false, url = "" },
            schemas = require("schemastore").yaml.schemas(),
         },
      },
   }
)
