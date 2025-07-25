return {
	dap = {
		ensure_installed = {
			"delve",
			-- "js" is installed manually
		},
		setup = function()
			require("dap-go").setup()

			require("dap-vscode-js").setup({

				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			})
			require("dap").adapters["pwa-node"] = {
				id = "pwa-node",
				type = "server",
				host = "localhost",
				port = 43229,
				executable = {
					command = "node",
					args = {
						"/home/pldcanfly/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"43229",
					},
				},
				options = {
					detached = false,
				},
			}
			for _, language in ipairs({ "typescript", "javascript", "svelte" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Current File",
						program = "${file}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Auto Attach",
						sourceMaps = true,
						resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
						cwd = "${workspaceFolder}/src",
						skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
					},
					{
						type = "pwa-node",
						request = "attach",
						processId = require("dap.utils").pick_process,
						name = "Attach to pid",
						sourceMaps = true,
						resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
						cwd = "${workspaceFolder}/src",
						skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
					},
					{
						type = "server",
						host = "localhost",
						port = "${port}",
						name = "New Way",
						executable = {
							command = "node",
							-- 💀 Make sure to update this path to point to your installation
							args = {
								"/home/pldcanfly/.local/share/nvim/lazy/vscode-js-debug/out/dist/src/dapDebugServer.js",
								"${port}",
							},
						},
					},
				}
			end
		end,
	},
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
			"ts_ls",
			"terraformls",
			"ansiblels",
			"templ",
			-- "trivy",
			-- "snyk",
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
				-- ts_ls = function()
				-- 	-- I am handled by typescript-tools
				-- end,
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

			-- Fix Terraform comment string
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
				callback = function(ev)
					vim.bo[ev.buf].commentstring = "# %s"
				end,
				pattern = { "terraform", "hcl" },
			})
		end,
	},
	nullls = {
		ensure_installed = { "stylua", "prettierd", "sql-formatter" },
		-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
		sources = function()
			local nls = require("null-ls")
			return {
				nls.builtins.formatting.stylua,
				-- nls.builtins.diagnostics.selene,
				nls.builtins.formatting.prettierd,
				nls.builtins.formatting.gofmt,
				nls.builtins.formatting.goimports,
				nls.builtins.formatting.terraform_fmt,
				nls.builtins.diagnostics.ansiblelint,
				-- nls.builtins.formatting.sql_formatter,
				-- nls.builtins.formatting.pg_format,
			}
		end,
	},
}
