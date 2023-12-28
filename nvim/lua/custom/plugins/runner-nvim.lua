
  return {
    'MarcHamamji/runner.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    config = function()
      require('runner').setup()
      local shell_handler = require('runner.handlers.helpers').shell_handler
      local choice = require('runner.handlers.helpers').choice
      local handler = choice({
        ['Run'] = shell_handler('make run -B'),
        ['Build'] = shell_handler('make build -B'),
      })
      require('runner').set_handler('go', handler)
      require('runner').set_handler('templ', handler)
    end
  }
