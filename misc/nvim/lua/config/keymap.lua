vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set({ "n", "v" }, "grd", vim.lsp.buf.definition, { desc = "Go: Definition" })
vim.keymap.set({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, { desc = "Code Format" })

vim.keymap.set({ "n", "v" }, "]p", "o<Esc>p", { desc = "Paste: Next Line" })
vim.keymap.set({ "n", "v" }, "[p", "O<Esc>P", { desc = "Paste: Prev Line" })

vim.keymap.set({ "n", "v" }, "]q", ":cnext<return>", { desc = "Quickfix: Next Item" })
vim.keymap.set({ "n", "v" }, "[q", ":cprev<return>", { desc = "Quickfix: Prev Item" })

vim.keymap.set({ "n" }, "<leader>w%", ":vsplit<return>", { desc = " Split Vertical" })
vim.keymap.set({ "n" }, '<leader>w"', ":split<return>", { desc = " Split horizontal" })

vim.keymap.set({ "n", "v" }, "]<Space>", "o<Esc>k", { desc = "Newline below" })
vim.keymap.set({ "n", "v" }, "[<Space>", "O<Esc>j", { desc = "Newline above" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
