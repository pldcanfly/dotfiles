vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set({ "n", "v" }, "gd", vim.lsp.buf.definition, { desc = "Go: Definition" })
vim.keymap.set({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, { desc = "Code Format" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })


