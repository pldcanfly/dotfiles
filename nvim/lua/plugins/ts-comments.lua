return {
	"folke/ts-comments.nvim",
	opts = {
		lang = {
			typescript = { "// %s", "/* %s */" },
		},
	},
	event = "VeryLazy",
	enabled = vim.fn.has("nvim-0.10.0") == 1,
}
