return {
	"williamboman/mason-lspconfig.nvim",
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = require("config.langs").lsp.ensure_installed,
		})
	end,
	dependencies = {
		"williamboman/mason.nvim",
	},
}
