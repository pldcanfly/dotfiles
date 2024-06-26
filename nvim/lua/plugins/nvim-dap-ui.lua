return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  keys = {
    {
      "<leader>du",
      function()
        require("dapui").toggle()
      end,
      silent = true,
    }
  },
  opts = {
    layouts = {
      {
        elements = {
          { id = "repl",    size = 0.30 },
          { id = "console", size = 0.70 },
        },
        size = 0.19,
        position = "bottom",
      },
      {
        elements = {
          { id = "scopes",      size = 0.30 },
          { id = "breakpoints", size = 0.20 },
          { id = "stacks",      size = 0.10 },
          { id = "watches",     size = 0.30 },
        },
        size = 0.20,
        position = "right",
      },
    }
  }
}
