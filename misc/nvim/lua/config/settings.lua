vim.g.have_nerd_font = false
vim.o.termguicolors = true
vim.o.winborder = "single"

-- Set locale and Spellchecking
vim.o.spelllang = "en,de"
vim.o.spell = true

-- linenumbers
vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = "a"
vim.o.showmode = false

-- This defers loading until UiEnter
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes"

-- Where to split to
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.cursorline = true

vim.o.breakindent = true

vim.o.scrolloff = 10
vim.o.sidescrolloff = 8

vim.o.confirm = true

vim.o.colorcolumn = "150"

-- Decrease update time
vim.o.updatetime = 100
vim.o.timeoutlen = 301

-- tabhandling
vim.o.tabstop = 3
vim.o.softtabstop = 0
vim.o.shiftwidth = 0
vim.o.expandtab = true

vim.o.exrc = true
