vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('plugins')
require('options')
require('keymaps')

require('config.harpoon')
require('config.lsp')
require('config.nvim-cmp')
require('config.prettier')
require('config.telescope')
require('config.treesitter')
