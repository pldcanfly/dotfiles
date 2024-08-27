return {
	-- https://github.com/stevearc/conform.nvim
	formatters = {
		lua = { "stylua" },
		sh = { "shfmt" },
	},
	-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#configuration
	lsp_ensure = {
		"lua_ls",
		"stylua",
		"bashls",
		"clangd",
		"tailwindcss",
		"cssls",
		"dockerls",
		"gopls",
		"graphql",
		"html",
		"eslint",
		"phpactor",
		"sqls"
	}
}
