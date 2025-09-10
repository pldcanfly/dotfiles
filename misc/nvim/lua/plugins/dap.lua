return {
   {
      "mfussenegger/nvim-dap",
      keys = {
         {
            "<leader>b",
            function()
               require("dap").toggle_breakpoint()
            end,
            desc = "DAP: Breakpoint",
         },
         { "<leader>d", nil, desc = "DAP" },
         {
            "<leader>dd",
            function()
               require("dap").clear_breakpoints()
            end,
            desc = "DAP: Delete Breakpoints",
         },
         {
            "<leader>dc",
            function()
               require("dap").continue()
            end,
            desc = "DAP: Continue",
         },

         {
            "<leader>dl",
            function()
               require("dap").step_into()
            end,
            desc = "DAP: Step Into",
         },
         {
            "<leader>dL",
            function()
               require("dap").step_over()
            end,
            desc = "DAP: Step Over ",
         },
         {
            "<leader>dH",
            function()
               require("dap").step_out()
            end,
            desc = "DAP: Step Out",
         },
         {
            "<leader>ds",
            function()
               local widgets = require("dap.ui.widgets")
               widgets.centered_float(widgets.scopes)
            end,
            desc = "DAP: Scopes",
         },
      },
      config = function()
         -- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
         local dap = require("dap")
         -- Adapter config
         dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
               command = "node",
               args = {
                  vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
                  "${port}",
               },
            },
         }
         dap.configurations.javascript = {
            {
               type = "pwa-node",
               request = "attach",
               name = "Attach to 9229",
               port = 9229,
               sourceMaps = true,
               resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
               skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
               cwd = "${workspaceFolder}",
            },
            {
               type = "pwa-node",
               request = "launch",
               name = "Launch Current File",
               program = "${file}",
               cwd = "${workspaceFolder}",
            },
         }
         dap.configurations.typescript = dap.configurations.javascript
      end,
   },
   {
      "leoluz/nvim-dap-go",
      dependencies = { "mfussenegger/nvim-dap" },
      config = true,
   },
}
