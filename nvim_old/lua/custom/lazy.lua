local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  require 'custom.plugins.lspconfig',
  require 'custom.plugins.go',
  require 'custom.plugins.tailwindsorter',
  require 'custom.plugins.cmp',
  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = {} },
  require 'custom.plugins.gitsigns',
  require 'custom.plugins.theme',
  require 'custom.plugins.lualine',
  require 'custom.plugins.blankline',
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  require 'custom.plugins.telescope',
  require 'custom.plugins.treesitter',
  require 'custom.plugins.runner-nvim',
  require 'custom.plugins.autopairs',

  require 'custom.plugins.oil',
  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  require 'kickstart.plugins.autoformat',
  require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})
