return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	lazy = false,
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		delete_to_trash = true,
		view_options = {
			show_hidden = true,
		},
	},
	keys = {
		{
			"<leader>fo",
			"<CMD>Oil<CR>",
			desc = "Oil",
		},
	},
}
