return {
   {
      "nvim-treesitter/nvim-treesitter",
      branch = "master",
      lazy = false,
      build = ":TSUpdate",
   },
   {
      "nvim-treesitter/nvim-treesitter-textobjects",
      depencencies = {
         "nvim-treesitter/nvim-treesitter",
      },
      config = function(_, opts)
         require("nvim-treesitter.configs").setup(opts)
      end,
      opts = {
         textobjects = {
            select = {
               enable = true,
               lookahead = true,
               keymaps = {
                  ["af"] = { query = "@function.outer", desc = "Around Function" },
                  ["if"] = { query = "@function.inner", desc = "Inside Function" },
                  ["ac"] = { query = "@class.outer", desc = "Around Class" },
                  ["ic"] = { query = "@class.inner", desc = "Inside Class" },
                  ["al"] = { query = "@loop.outer", desc = "Around Loop" },
                  ["il"] = { query = "@loop.inner", desc = "Inside Loop" },
                  ["ai"] = { query = "@condition.outer", desc = "Around Condition" },
                  ["ii"] = { query = "@condition.inner", desc = "Inside Condition" },
               },
               selection_modes = {
                  ["@parameter.outer"] = "v", -- charwise
                  ["@function.outer"] = "V", -- linewise
                  ["@class.outer"] = "V", -- blockwise
               },
               include_surrounding_whitespace = true,
            },
            swap = {
               enable = true,
               swap_next = {
                  ["<leader>p"] = { query = "@parameter.inner", desc = "Move Parameter Left" },
               },
               swap_previous = {
                  ["<leader>P"] = { query = "@parameter.inner", desc = "Move Parameter Right" },
               },
            },
            move = {
               enable = true,
               set_jumps = true, -- whether to set jumps in the jumplist
               goto_next_start = {
                  ["]f"] = { query = "@function.outer", desc = "Next Function Start" },
                  ["]c"] = { query = "@class.outer", desc = "Next Class Start" },
                  ["]a"] = { query = "@paramater.inner", desc = "Next Parameter Start" },
               },
               goto_next_end = {
                  ["]f"] = { query = "@function.outer", desc = "Next Function End" },
                  ["]c"] = { query = "@class.outer", desc = "Next Class End" },
               },
               goto_previous_start = {
                  ["[F"] = { query = "@function.outer", desc = "Prev Function Start" },
                  ["[C"] = { query = "@class.outer", desc = "Prev Class Start" },
                  ["[A"] = { query = "@paramater.inner", desc = "Prev Parameter Start" },
               },
               goto_previous_end = {
                  ["[F"] = { query = "@function.outer", desc = "Prev Function End" },
                  ["[C"] = { query = "@class.outer", desc = "Prev Class End" },
               },
               goto_next = {
                  ["]i"] = { query = "@conditional.outer", desc = "Next Conditional Start/End" },
                  ["]l"] = { query = "@loop.outer", desc = "Next Conditional Start/End" },
               },
               goto_previous = {
                  ["[i"] = { query = "@conditional.outer", desc = "Next Conditional Start/End" },
                  ["[L"] = { query = "@loop.outer", desc = "Next Conditional Start/End" },
               },
            },
         },
      },
   },
}
