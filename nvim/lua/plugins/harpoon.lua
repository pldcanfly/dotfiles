local keys = {
   {
      "<leader>ha",
      function()
         require("harpoon"):list():add()
      end,
      desc = "Harpoon: Add",
   },
   {
      "<leader>hl",
      function()
         require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
      end,
      desc = "Harpoon: List",
   },
}

for i = 1, 9 do
   table.insert(keys, {
      "<C-" .. i .. ">",
      function()
         require("harpoon"):list():select(i)
      end,
      desc = "Harpoon: " .. i,
   })
end

return {
   "ThePrimeagen/harpoon",
   branch = "harpoon2",
   dependencies = { "nvim-lua/plenary.nvim" },
   opt = true,
   keys = keys,
}
