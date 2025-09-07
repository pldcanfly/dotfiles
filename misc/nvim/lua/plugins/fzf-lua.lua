return {
   "ibhagwan/fzf-lua",
   dependencies = { "nvim-mini/mini.icons" },
   opts = {},
   keys = {
      {
         "<leader>ff",
         function()
            require("fzf-lua").files()
         end,
         desc = "Find Files",
      },
      {
         "<leader>fg",
         function()
            require("fzf-lua").live_grep()
         end,
         desc = "Find Files with grep",
      },
      {
         "<leader>fh",
         function()
            require("fzf-lua").helptags()
         end,
         desc = "Find in help",
      },
      {
         "<leader>fk",
         function()
            require("fzf-lua").keymaps()
         end,
         desc = "Find in keymaps",
      },
      {
         "<leader><leader>",
         function()
            require("fzf-lua").buffers()
         end,
         desc = "Buffers",
      },
      {
         "<leader>/",
         function()
            require("fzf-lua").lgrep_curbuf()
         end,
         desc = "Fzf-grep",
      },
   },
}
