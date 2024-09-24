vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.keymap.set({ "n", "v" }, "]p", "o<Esc>p", { desc = "Paste: Next Line" })
vim.keymap.set({ "n", "v" }, "[p", "O<Esc>P", { desc = "Paste: Prev Line" })

vim.keymap.set({ "n", "v" }, "gd", vim.lsp.buf.definition, { desc = "Go: Definition" })
vim.keymap.set({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, { desc = "Code Format" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
