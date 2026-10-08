local companion = require("schema-companion")
local lsp_source = companion.sources.lsp.setup()
-- multi-document aware replacement for companion.sources.matchers.kubernetes,
-- see lua/config/k8s_schema.lua
local k8s = require("config.k8s_schema").setup({ version = "v1.33.0" })

local adapter = companion.adapters.yamlls.setup({
   sources = {
      k8s,
      -- schema list for the picker only; its per-file match() does a
      -- sync request to yamlls that blocked :edit for up to 5s
      {
         name = lsp_source.name,
         get_schemas = function(_, ctx, bufnr)
            return lsp_source:get_schemas(ctx, bufnr)
         end,
      },
   },
})

-- upstream maps each schema uri to a single buffer, so a uri shared by several
-- buffers (the one k8s all.json from config.k8s_schema) only applies to
-- whichever buffer matched last; yamlls accepts a list of globs, so keep all
function adapter:on_update_schemas(bufnr, schemas)
   local bufuri = vim.uri_from_bufnr(bufnr)
   local client = self:get_client()

   local next = {}
   for uri, files in pairs(vim.tbl_get(client, "settings", "yaml", "schemas") or {}) do
      local kept = vim.tbl_filter(function(file)
         return file ~= bufuri
      end, type(files) == "table" and files or { files })
      if #kept > 0 then
         next[uri] = kept
      end
   end
   for _, schema in ipairs(schemas) do
      next[schema.uri] = next[schema.uri] or {}
      table.insert(next[schema.uri], bufuri)
   end

   -- assign rather than tbl_deep_extend, which would merge the lists index-wise
   client.settings.yaml.schemas = next
   client:notify("workspace/didChangeConfiguration", { settings = client.settings })
end

---@type vim.lsp.Config
return companion.setup_client(adapter, {
   cmd = { "yaml-language-server", "--stdio" },
   filetypes = { "yaml", "yaml.gitlab", "yaml.docker-compose" },
   root_markers = { ".git" },
   on_attach = function(client, bufnr)
      -- schema-companion matches only once, on attach, and a new file is still
      -- empty then; pick up the k8s schema once apiVersion/kind are written
      vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
         group = vim.api.nvim_create_augroup("yamlls-k8s-rematch-" .. bufnr, { clear = true }),
         buffer = bufnr,
         callback = function()
            local current = require("schema-companion.context").get_schemas(bufnr, client.id) or {}
            if vim.iter(current):any(function(schema)
               return schema.uri ~= nil
            end) then
               -- has a schema, matched or picked by hand: stop watching
               return true
            end
            if #k8s:match(nil, bufnr) > 0 then
               require("schema-companion.schema").match(bufnr)
               return true
            end
         end,
      })
   end,
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
})
