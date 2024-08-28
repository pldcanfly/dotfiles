return {
	lsp = {
		ensure_installed = {
			"lua_ls",
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
			"sqls",
		},

		setup = function()
			require("lspconfig").lua_ls.setup({
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
						return
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force",
						client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- Depending on the usage, you might want to add additional paths here.
								-- "${3rd}/luv/library"
								-- "${3rd}/busted/library",
							},
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
							-- library = vim.api.nvim_get_runtime_file("", true)
						},
					})
				end,
				settings = {
					Lua = {},
				},
			})

			require("lspconfig").bashls.setup({})
			require("lspconfig").clangd.setup({})
			require("lspconfig").tailwindcss.setup({})
			require("lspconfig").cssls.setup({})
			require("lspconfig").dockerls.setup({})
			require("lspconfig").gopls.setup({})
			require("lspconfig").graphql.setup({})
			require("lspconfig").html.setup({})
			require("lspconfig").eslint.setup({})
			require("lspconfig").phpactor.setup({})
			require("lspconfig").sqls.setup({})
		end,
	},
	nullls = {
		ensure_installed = { "stylua", "prettierd" },
		-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
		sources = function()
			local nls = require("null-ls")
			return {
				nls.builtins.formatting.stylua,
				-- nls.builtins.diagnostics.selene,
				nls.builtins.formatting.prettierd,
			}
		end,
	},
}
