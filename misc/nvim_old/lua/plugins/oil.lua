return {
	"stevearc/oil.nvim",
	opts = {
		delete_to_trash = true,
		view_options = {
			show_hidden = true,
			natural_order = true,
		},
		float = {
			padding = 5,
		},
	},
	keys = {
		{ "<leader>fo", "<cmd>Oil --float<cr>", { desc = "Open Oil" } },
	},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
}
