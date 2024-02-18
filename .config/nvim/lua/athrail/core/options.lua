vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'

vim.o.breakindent = true
vim.o.undofile = true
-- Indentation setup
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
