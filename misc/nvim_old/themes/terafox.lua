return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		dim_inactive = true,
	},
	init = function()
		vim.cmd.colorscheme("carbonfox")
	end,
}
