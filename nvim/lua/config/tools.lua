-- Single source of truth for external tooling.
--
-- `servers` uses nvim-lspconfig names (see nvim/lsp/ for per-server overrides):
--   https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- `formatters` / `linters` use mason package names, and should mirror the
-- sources configured in lua/plugins/none-ls.lua:
--   https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
--
-- mason-lspconfig installs `servers`, mason-tool-installer installs the rest.

local M = {}

M.servers = {
	"ansiblels",
	"arduino_language_server",
	"bashls",
	"docker_compose_language_service",
	"docker_language_server",
	"gopls",
	"hyprls",
	"just",
	"lua_ls",
	"terraformls",
	"ts_ls",
	"yamlls",
}

M.formatters = {
	"goimports",
	"prettierd",
	"shfmt",
	"stylua",
	-- gofmt ships with the Go toolchain, `terraform fmt` with terraform, and
	-- `just --fmt` with just; none of those are mason packages.
}

M.linters = {
	"ansible-lint",
	"kube-linter",
	"yamllint",
}

-- Everything mason-tool-installer should manage directly (mason package names).
function M.mason_tools()
	local tools = {}
	vim.list_extend(tools, M.formatters)
	vim.list_extend(tools, M.linters)
	return tools
end

return M
