local keys = {
		{"<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon: Add" },
		{"<C-e>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon: Menu" },
		-- Toggle previous & next buffers stored within Harpoon list
		{"<C-S-P>", function() require("harpoon"):list():prev() end, desc = "Harpoon: Prev" },
		{"<C-S-N>", function() require("harpoon"):list():next() end, desc = "Harpoon: Next" },
	}

for i = 1,9 do
	table.insert(keys, {"<C-" .. i .. "1>", function() require("harpoon"):list():select(i) end, desc = "Harpoon: " .. i .. "" })
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{"<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon: Add" },
		{"<C-e>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon: Menu" },
		{"<C-1>", function() require("harpoon"):list():select(1) end, desc = "Harpoon: 1" },
		{"<C-2>", function() require("harpoon"):list():select(2) end, desc = "Harpoon: 2" },
		{"<C-3>", function() require("harpoon"):list():select(3) end, desc = "Harpoon: 3" },
		{"<C-4>", function() require("harpoon"):list():select(4) end, desc = "Harpoon: 4" },
		-- Toggle previous & next buffers stored within Harpoon list
		{"<C-S-P>", function() require("harpoon"):list():prev() end, desc = "Harpoon: Prev" },
		{"<C-S-N>", function() require("harpoon"):list():next() end, desc = "Harpoon: Next" },
	}
}
