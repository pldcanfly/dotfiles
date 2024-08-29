return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"wiliamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},
	opts = {
		ensure_installed = require("config.langs").nullls.ensure_installed,
	},
}
