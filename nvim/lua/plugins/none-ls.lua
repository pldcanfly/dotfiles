return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")

			local lsp_formatting = function(bufnr)
				vim.lsp.buf.format({
					filter = function(client)
						-- apply whatever logic you want (in this example, we'll only use null-ls)
						return client.name == "null-ls"
					end,
					bufnr = bufnr,
				})
			end

			-- if you want to set up formatting on save, you can use this as a callback
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			-- add to your shared on_attach callback
			local on_attach = function(client, bufnr)
				if client:supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							lsp_formatting(bufnr)
						end,
					})
				end
			end

			null_ls.setup({
				-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
				--
				-- yaml.ansible buffers are linted by ansiblels alone: it runs ansible-lint
				-- on open/save, and ansible-lint already embeds yamllint through its
				-- yaml[*] rules. none-ls matches dotted filetypes on each component, so
				-- the plain "yaml" sources below must opt out of yaml.ansible explicitly
				-- or every long line gets reported twice (160 vs 80 column defaults).
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.gofmt,
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.terraform_fmt,
					null_ls.builtins.formatting.shfmt,
					null_ls.builtins.formatting.just,
					null_ls.builtins.diagnostics.kube_linter.with({
						-- kube-linter lints $ROOT from disk, so unsaved edits are invisible
						-- to it: run it on open/save instead of after every text change,
						-- and don't trigger repo-wide scans from ansible buffers.
						method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
						disabled_filetypes = { "yaml.ansible" },
					}),
					null_ls.builtins.diagnostics.yamllint.with({
						disabled_filetypes = { "yaml.ansible" },
					}),
					null_ls.builtins.diagnostics.actionlint.with({
						-- default condition only covers .github; we also use gitea/forgejo
						runtime_condition = function(params)
							return params.bufname:find("%.github[\\/]workflows") ~= nil
								or params.bufname:find("%.gitea[\\/]workflows") ~= nil
								or params.bufname:find("%.forgejo[\\/]workflows") ~= nil
						end,
					}),
				},
				on_attach = on_attach,
			})
		end,
	},
}
