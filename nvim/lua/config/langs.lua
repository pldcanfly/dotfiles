return {
	lsp = {
		ensure_installed = {
			"lua_ls",
			"bashls",
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
		setup = function(installed)
			local lspconfig = require("lspconfig")
			-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local server_configs = {
				lua_ls = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_init = function(client)
							local path = client.workspace_folders[1].name
							if
								vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc")
							then
								return
							end

							client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
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
					})
				end,
			}

			for _, server in ipairs(installed) do
				if server_configs[server] then
					-- Apply specific configuration if it exists
					server_configs[server]()
				else
					-- Apply default configuration with nvim-cmp capabilities
					lspconfig[server].setup({
						capabilities = capabilities, -- Include nvim-cmp capabilities
					})
				end
			end
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
