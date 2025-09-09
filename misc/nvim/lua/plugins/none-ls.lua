return {
   {
      "nvimtools/none-ls.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
         local null_ls = require("null-ls")
         null_ls.setup({
            sources = {
               null_ls.builtins.formatting.stylua,
               null_ls.builtins.diagnostics.eslint,
               null_ls.builtins.completion.spell,
               null_ls.builtins.formatting.prettierd,
               null_ls.builtins.formatting.gofmt,
               null_ls.builtins.formatting.goimports,
               null_ls.builtins.formatting.terraform_fmt,
               null_ls.builtins.diagnostics.ansiblelint,
            },
         })
      end,
   },
   {
      "lukas-reineke/lsp-format.nvim",
      config = function()
         require("lsp-format").setup({})

         vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
               local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
               require("lsp-format").on_attach(client, args.buf)
            end,
         })
      end,
   },
}
