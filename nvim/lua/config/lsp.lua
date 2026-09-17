-- Server list lives in config.tools so mason can install the same set
vim.lsp.enable(require("config.tools").servers)

vim.diagnostic.config({
	virtual_text = true,
})

-- Ansible files. Detected here rather than from a BufRead autocmd so the
-- buffer is yaml.ansible on its first FileType event: flipping the filetype
-- afterwards fired FileType twice, which started yamlls for "yaml" and then
-- detached it again on every ansible file open. Non-negative-priority
-- patterns are checked before the yml/yaml extension table, so these win.
vim.filetype.add({
	pattern = {
		[".*/ansible/.*%.ya?ml"] = "yaml.ansible",
		[".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
		[".*/roles/.*%.ya?ml"] = "yaml.ansible",
	},
})
