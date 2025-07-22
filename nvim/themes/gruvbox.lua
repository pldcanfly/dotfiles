return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		dim_inactive = true,
	},
	init = function()
		vim.o.background = "dark"
		vim.cmd.colorscheme("gruvbox")
	end,
}
