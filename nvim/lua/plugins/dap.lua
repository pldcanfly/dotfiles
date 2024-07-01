return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'nvim-neotest/nvim-nio',
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!

    -- Dap UI setup
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
layouts = {
      {
        elements = {
          { id = "repl",    size = 0.30 },
          -- { id = "console", size = 0.70 },
          { id = "scopes",      size = 0.70 },
        },
        size = 0.19,
        position = "bottom",
      },
      {
        elements = {
          { id = "breakpoints", size = 0.20 },
          { id = "stacks",      size = 0.80 },
          -- { id = "watches",     size = 0.30 },
        },
        size = 0.20,
        position = "left",
      },
      },
 floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil, -- Floats will be treated as percentage of your screen.
          border = "single", -- Border style. Can be "single", "double" or "rounded"
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<leader>xo', dapui.toggle, { desc = 'Debug: See last session result.' })
      vim.keymap.set('n', '<leader>xd', function() require("dap").clear_breakpoints() end, { desc = "Clear Breakpoints" })
      vim.keymap.set('n', '<leader>xj', function() require("dap").continue() end, { desc = "Continue" })
      vim.keymap.set('n', '<leader>xJ', function() require("dap").step_into() end, { desc = "Step Into" })
      vim.keymap.set('n', '<leader>xl', function() require("dap").step_over() end, { desc = "Step Over" })
      vim.keymap.set('n', '<leader>xL', function() require("dap").step_out() end, { desc = "Step Out" })
      
      vim.keymap.set('n', '<leader>xu', function() require("dapui").toggle() end, { desc = "Toggle Debugger UI" })
      vim.keymap.set('n', '<leader>xs', function() require("dapui").float_element("scopes", { enter = true }) end, { desc = "Scopes" })
      vim.keymap.set('n', '<leader>xr', function() require("dap").repl.toggle() end, { desc = "REPL" })
      vim.keymap.set('n', '<leader>xt', function() require("dapui").float_element("stacks", { enter = true }) end, { desc = "Threads" })
      vim.keymap.set('n', '<leader>xw', function() require("dapui").float_element("watches", { enter = true }) end, { desc = "Watches" })
      vim.keymap.set('n', '<leader>xb', function() require("dapui").float_element("breakpoints", { enter = true }) end, { desc = "List Breakpoints" })
  vim.keymap.set('n', '<leader>xn', function()
    vim.cmd.DapNew
end, opt)    
    vim.keymap.set('n', '<leader>xx', function() require("dap.ui.widgets").hover() end, { desc = "Inspect" })

    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
  end,
}
