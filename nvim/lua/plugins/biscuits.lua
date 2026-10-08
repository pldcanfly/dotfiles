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
      -- attaching walks every treesitter node on the main thread; on a 1.5 MB
      -- CRD bundle that froze nvim for ~10-40s
      max_file_size = "200kb",
   },
}
