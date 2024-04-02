return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = {
    theme = 'doom',
    config = {
      center = {
        {
          icon = '',
          icon_hl = 'group',
          desc = 'description',
          desc_hl = 'group',
          key = 'shortcut key in dashboard buffer not keymap !!',
          key_hl = 'group',
          key_format = ' [%s]', -- `%s` will be substituted with value of `key`
          action = '',
        },
      },
    },
  },
  dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
