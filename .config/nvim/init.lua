local vim = vim

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

vim.keymap.set('n', '<leader>%', '<C-w>v<C-w>w')
vim.keymap.set('n', '<leader>"', '<C-w>s<C-w>w')

vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-j>', '<C-w>j')

vim.keymap.set('n', '<leader>bd', ':bd<CR>')
vim.keymap.set('n', '<leader>bD', ':bd!<CR>')

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+yy')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+dd')

-- Git blame for selection
local function git_blame()
  local lines_start = vim.fn.line('v')
  local lines_end   = vim.fn.line('.')

  vim.cmd(string.format(':Git blame -L%d,%d -- %%', lines_start, lines_end))
end
vim.keymap.set('v', '<leader>gb', git_blame)

-- Plugins
vim.pack.add({
  { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/echasnovski/mini.nvim' },
  { src = 'https://github.com/chomosuke/typst-preview.nvim' },
  { src = 'https://github.com/j-hui/fidget.nvim' },
})

require 'tokyonight'.setup({
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
  }
})
vim.cmd('autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE')
vim.cmd('colorscheme tokyonight')

require 'nvim-treesitter.configs'.setup({
  ensure_installed = { 'c', 'cpp', 'python', 'json', 'yaml' },
  highlight = { enable = true }
})

local win_config = function()
  local height = math.floor(0.618 * vim.o.lines)
  local width = math.floor(0.618 * vim.o.columns)
  return {
    anchor = 'NW',
    height = height,
    width = width,
    row = math.floor(0.5 * (vim.o.lines - height)),
    col = math.floor(0.5 * (vim.o.columns - width)),
  }
end

require 'mini.pick'.setup(
  { window = { config = win_config } }
)
require 'mini.extra'.setup()
vim.keymap.set('n', '<leader>ff', MiniPick.builtin.files)
vim.keymap.set('n', '<leader>fg', MiniPick.builtin.grep_live)
vim.keymap.set('n', '<leader>fw', function()
  MiniPick.builtin.grep({ pattern = vim.fn.expand('<cword>') or '' })
end)
vim.keymap.set('n', '<leader>fh', MiniPick.builtin.help)
vim.keymap.set('n', '<leader><leader>', MiniPick.builtin.buffers)
vim.keymap.set('n', '<leader>\'', MiniPick.builtin.resume)

vim.keymap.set('n', 'grr', ":Pick lsp scope=\"references\"<CR>")
vim.keymap.set('n', 'grs', ":Pick lsp scope=\"workspace_symbol\"<CR>")
vim.keymap.set('n', 'gd', ":Pick lsp scope=\"definition\"<CR>")
vim.keymap.set('n', 'gri', ":Pick lsp scope=\"implementation\"<CR>")
vim.keymap.set('n', 'gO', ":Pick lsp scope=\"document_symbol\"<CR>")

require 'mini.align'.setup()
require 'mini.completion'.setup()
require 'mini.trailspace'.setup()
require 'mini.statusline'.setup()
require 'mini.surround'.setup()
require 'typst-preview'.setup()
require 'fidget'.setup({
  notification = {
    override_vim_notify = true,
  },
})

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
vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  root_markers = { 'mod.go' },
  filetypes = { 'go' },
})

vim.lsp.config.clangd = {
  cmd = {
    'clangd',
    '--clang-tidy',
    '--background-index',
    '--offset-encoding=utf-8',
  },
  root_markers = { '.clangd', 'compile_commands.json' },
  filetypes = { 'c', 'cpp' },
}

vim.lsp.config('pylsp', {
  filetypes = { 'py' },
  root_markers = { 'pyproject.toml' },
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

vim.lsp.config('ruby-lsp', {
  cmd = { "ruby-lsp" },
  filetypes = { "ruby", "eruby" },
  root_markers = { "Gemfile", ".git" },
})

vim.lsp.config('tinymist', {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  root_markers = { '.git' },
})

vim.lsp.enable({ 'pylsp', 'clangd', 'tinymist', 'gopls' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
