return {
   "folke/persistence.nvim",
   event = "BufReadPre",
   opts = {},
   init = function()
      vim.api.nvim_create_autocmd("StdinReadPre", {
         callback = function()
            vim.g.started_with_stdin = true
         end,
      })

      -- restore the cwd-session only for a bare `nvim` (this is how tmux-resurrect relaunches it)
      vim.api.nvim_create_autocmd("VimEnter", {
         group = vim.api.nvim_create_augroup("restore-session", { clear = true }),
         nested = true,
         callback = function()
            if vim.fn.argc(-1) == 0 and not vim.env.NVIM and not vim.g.started_with_stdin then
               require("persistence").load()
            end
         end,
      })
   end,
}
