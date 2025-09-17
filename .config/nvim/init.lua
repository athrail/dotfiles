-- General options
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.swapfile = false
vim.g.mapleader = ' '
vim.o.winborder = 'rounded'
vim.o.clipboard = 'unnamedplus'
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 20
vim.o.cursorline = true
vim.o.completeopt = 'menu,menuone,noinsert'
vim.o.termguicolors = true

-- Diagnostics configuration
vim.diagnostic.config({
  underline = true,
  signs = true,
  virtual_lines = false,
  virtual_text = true,
})

-- General keymap
vim.keymap.set('n', '<leader>o', ':update<CR>:source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<Esc>', ':noh<Return><Esc>', { silent = true })

vim.keymap.set('n', '<leader>%', '<C-w><C-v><C-w><C-w>')
vim.keymap.set('n', '<leader>"', '<C-w><C-s><C-w><C-w>')

vim.keymap.set('n', '<leader>bd', ':bd<CR>')
vim.keymap.set('n', '<leader>bD', ':bd!<CR>')

vim.keymap.set({'n','v','x'}, '<leader>y', '"+yy')
vim.keymap.set({'n','v','x'}, '<leader>d', '"+dd')

-- Git blame for selection
function git_blame()
  local lines_start = vim.fn.line('v')
  local lines_end   = vim.fn.line('.')

  vim.cmd(string.format(':Git blame -L%d,%d -- %%', lines_start, lines_end))
end
vim.keymap.set('v', '<leader>gb', git_blame)

-- Plugins
vim.pack.add({
  { src = 'https://github.com/rose-pine/neovim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/mbbill/undotree' },
  { src = 'https://github.com/echasnovski/mini.icons' },
  { src = 'https://github.com/echasnovski/mini-git' },
  { src = 'https://github.com/echasnovski/mini.align' },
  { src = 'https://github.com/echasnovski/mini.pairs' },
  { src = 'https://github.com/echasnovski/mini.statusline' },
  { src = 'https://github.com/echasnovski/mini.surround' },
  { src = 'https://github.com/echasnovski/mini.completion' },
  { src = 'https://github.com/echasnovski/mini.trailspace' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
  { src = 'https://github.com/chomosuke/typst-preview.nvim' },
})

require 'rose-pine'.setup({
  styles = { italic = false },
})
vim.cmd('autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE')
vim.cmd('colorscheme rose-pine')

require 'nvim-treesitter.configs'.setup({
  ensure_installed = { 'c', 'cpp', 'python', 'json', 'yaml' },
  highlight = { enable = true }
})

local telescope = require('telescope')
telescope.setup({
  defaults = {
    layout_strategy = 'vertical',
  },
  pickers = {
    current_buffer_tags = { fname_width = 100, },
    jumplist = { fname_width = 100, },
    loclist = { fname_width = 100, },
    lsp_definitions = { fname_width = 100, },
    lsp_document_symbols = { fname_width = 100, },
    lsp_dynamic_workspace_symbols = { fname_width = 100, },
    lsp_implementations = { fname_width = 100, },
    lsp_incoming_calls = { fname_width = 100, },
    lsp_outgoing_calls = { fname_width = 100, },
    lsp_references = { fname_width = 100, },
    lsp_type_definitions = { fname_width = 100, },
    lsp_workspace_symbols = { fname_width = 100, },
    quickfix = { fname_width = 100, },
    tags = { fname_width = 100, },
  }
})

local tbuiltin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', tbuiltin.find_files)
vim.keymap.set('n', '<leader>fg', tbuiltin.live_grep)
vim.keymap.set('n', '<leader>fw', tbuiltin.grep_string)
vim.keymap.set('n', '<leader><space>', tbuiltin.buffers)
vim.keymap.set('n', '<leader>fh', tbuiltin.help_tags)
vim.keymap.set('n', '<leader>\'', tbuiltin.resume)

vim.keymap.set('n', 'grr', tbuiltin.lsp_references)
vim.keymap.set('n', 'grs', tbuiltin.lsp_workspace_symbols)
vim.keymap.set('n', 'gd', tbuiltin.lsp_definitions)
vim.keymap.set('n', 'gri', tbuiltin.lsp_implementations)
vim.keymap.set('n', 'gO', tbuiltin.lsp_document_symbols)

require 'mini.git'.setup()
require 'mini.align'.setup()
require 'mini.completion'.setup()
require 'mini.trailspace'.setup()
require 'mini.pairs'.setup()
require 'mini.statusline'.setup()
require 'mini.surround'.setup()
require 'render-markdown'.setup({
  latex = { enabled = false },
  html = { enabled = false }
})
require 'typst-preview'.setup()

vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>')

require 'oil'.setup({
  columns = {
    'icon',
    'permissions',
    'size',
    'mtime',
  },
  view_options = {
    show_hidden = true,
    case_insensitive = true,
  }
})
vim.keymap.set('n', '<leader>e', ':Oil<CR>')

-- LSP section
vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--clang-tidy',
    '--background-index',
  }
})

vim.lsp.config('pylsp', {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          maxLineLength = 120,
        }
      }
    }
  }
})

vim.lsp.enable({ 'pylsp', 'clangd', 'tinymist' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
