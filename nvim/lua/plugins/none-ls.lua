return {
	"nvimtools/none-ls.nvim",
	config = function()
		local nls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		nls.setup({
			sources = require("config.langs").nullls.sources(),

			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})
	end,
	keys = {
		{ "<leader>F", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", desc = "Format Buffer" },
	},
}
