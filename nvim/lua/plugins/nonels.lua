return {
  "nvimtools/none-ls.nvim",
  init = function()
    local null_ls = require('null-ls')

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.phpcsfixer,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.sqlfluff.with({
          extra_args = { "--dialect", "postgres" }, -- change to your dialect
        }),
      }
    })
  end,
}
