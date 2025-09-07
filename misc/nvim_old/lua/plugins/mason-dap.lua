return {
	"jay-babu/mason-nvim-dap.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap",
	},
	opts = {
		ensure_installed = require("config.langs").dap.ensure_installed,
	},
}
