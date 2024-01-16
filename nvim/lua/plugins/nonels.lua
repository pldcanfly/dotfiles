return {
  "nvimtools/none-ls.nvim",
  -- opts = {
  --   sources = {
  --     null_ls.buildins.formating.phpcsfixer
  --   }
  -- }
  init = function()
    local null_ls = require('null-ls')

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.phpcsfixer
      }
    })
  end,
}
