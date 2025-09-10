return {
   "code-biscuits/nvim-biscuits",
   dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
   },
   opts = {
      default_config = {
         max_length = 60,
         min_distance = 2,
         prefix_string = "󱃖 ",
      },
      cursor_line_only = true,
   },
}
