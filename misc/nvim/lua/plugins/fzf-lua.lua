return {
   "ibhagwan/fzf-lua",
   dependencies = { "nvim-mini/mini.icons" },
   opts = {},
   keys = {
      {
         "<leader>ff",
         mode = { "n", "x" },
         function()
            require("fzf-lua").files()
         end,
         desc = "Fzf: Files",
      },
      {
         "<leader>fg",
         mode = { "n", "x" },
         function()
            require("fzf-lua").live_grep()
         end,
         desc = "Fzf: Grep files",
      },
      {
         "<leader>fh",
         mode = { "n", "x" },
         function()
            require("fzf-lua").helptags()
         end,
         desc = "Fzf: Help",
      },
      {
         "<leader>fk",
         mode = { "n", "x" },
         function()
            require("fzf-lua").keymaps()
         end,
         desc = "Fzf: Keymaps",
      },
      {
         "<leader>fs",
         mode = { "n", "x" },
         function()
            require("fzf-lua").lsp_document_symbols()
         end,
         desc = "Fzf: Symbols",
      },
      {
         "grr",
         function()
            require("fzf-lua").lsp_references()
         end,
         desc = "Fzf: References",
      },
      {
         "<leader><leader>",
         mode = { "n", "x" },
         function()
            require("fzf-lua").buffers()
         end,
         desc = "Fzf: Buffers",
      },
      {
         "<leader>/",
         mode = { "n", "x" },
         function()
            require("fzf-lua").lgrep_curbuf()
         end,
         desc = "Fzf: Grep",
      },
   },
}
