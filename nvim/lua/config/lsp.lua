local langs = {
	"arduino_language_server",
	"gopls",
	"lua_ls",
	"ts_ls",
	"docker_language_server",
	"docker_compose_language_service",
	"ansiblels",
	"bashls",
	"terraformls",
	"hyprls",
	"just",
	"yamlls",
}
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

vim.lsp.enable(langs)

vim.diagnostic.config({
	virtual_text = true,
})

-- Automatically setup ansible
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*/ansible/*.yml", "*/playbooks/*.yml", "*/roles/*.yml" },
	callback = function()
		vim.bo.filetype = "yaml.ansible"
	end,
})
