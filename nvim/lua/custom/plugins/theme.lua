-- return {
--   'catppuccin/nvim',
--   name = 'catppuccin',
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme 'catppuccin-mocha'
--   end,
-- }

return {
  'EdenEast/nightfox.nvim',
  priority = 1000,
  config = function()
    -- require('nightfox').setup({
    --   options = {
    --     terminal_colors = false,
    --     styles = {
    --       comments = "italic",
    --     }
    --   }
    -- })
    vim.cmd.colorscheme 'terafox'
  end
}
