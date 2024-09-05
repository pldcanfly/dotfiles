return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		require("typescript-tools").setup({
			capabilities = capabilities,
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
		})
	end,
	ft = {
		"javascript",
		"typescript",
	},
	keys = {
		{ "<leader>ts",  nil,                                    desc = "TS-Tools" },
		{ "<leader>tso", "<cmd>TSToolsOrganizeImports<cr>",      desc = "Sort&Remove Imports" },
		{ "<leader>tss", "<cmd>TSToolsSortImports<cr>",          desc = "Sort Imports" },
		{ "<leader>tsu", "<cmd>TSToolsRemoveUnusedImports<cr>",  desc = "Remove Unused Imports" },
		{ "<leader>tsd", "<cmd>TSToolsRemoveUnused<cr>",         desc = "Remove Unused Statemends" },
		{ "<leader>tsi", "<cmd>TSToolsAddMissingImports<cr>",    desc = "Add Imports" },
		{ "<leader>tsa", "<cmd>TSToolsFixAll<cr>",               desc = "Fix Errors" },
		{ "<leader>tsg", "<cmd>TSToolsGoToSourceDefinition<cr>", desc = "Goto Source Definition" },
		{ "<leader>tsr", "<cmd>TSToolsRenameFile<cr>",           desc = "Rename File" },
		{ "<leader>tsf", "<cmd>TSToolsFileReferences<cr>",       desc = "Find References" },
	},
}
