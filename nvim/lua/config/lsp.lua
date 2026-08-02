-- Server list lives in config.tools so mason can install the same set
vim.lsp.enable(require("config.tools").servers)

vim.diagnostic.config({
	virtual_text = true,
})

-- Automatically setup ansible
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		"*/ansible/*.yml",
		"*/playbooks/*.yml",
		"*/roles/*.yml",
		"*/ansible/*.yaml",
		"*/playbooks/*.yaml",
		"*/roles/*.yaml",
	},
	callback = function()
		vim.bo.filetype = "yaml.ansible"
	end,
})
