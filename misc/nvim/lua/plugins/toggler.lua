return {
	"nguyenvukhang/nvim-toggler",
	config = true,
	keys = {
		{
			"<leader>i",
			function()
				require("nvim-toggler").toggle()
			end,
			desc = "Invert state",
			mode = "n",
		},
	},
}
