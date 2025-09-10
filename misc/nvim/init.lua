-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

require("config.keymap")
require("config.settings")
require("config.autocmds")
require("config.lazy")

require("config.lsp")

