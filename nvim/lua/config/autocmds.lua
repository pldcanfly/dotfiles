-- [[ Highlight on yank ]]
-- See `:help vim.hl.hl_op()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.hl_op()
	end,
	group = highlight_group,
	pattern = "*",
})
