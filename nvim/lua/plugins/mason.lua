return {
	"williamboman/mason.nvim",
	name = "mason.nvim",
	cmd = "Mason",
	dependencies = {
		{ "williamboman/mason-lspconfig.nvim", opts = { automatic_installation = true, ensure_installed = require("config.langs").ensure_lsp } }
	},
	build = ":MasonUpdate",
	config = true
}
