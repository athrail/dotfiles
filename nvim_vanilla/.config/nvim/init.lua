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
vim.keymap.set('n', '<C-s>', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<Esc>', ':noh<Return><Esc>', { silent = true })

vim.keymap.set('n', '<leader>%', '<C-w>v<C-w>w')
vim.keymap.set('n', '<leader>"', '<C-w>s<C-w>w')

vim.keymap.set('n', '<leader>bd', ':bd<CR>')
vim.keymap.set('n', '<leader>bD', ':bd!<CR>')

-- Git blame for selection
local function git_blame()
  local lines_start = vim.fn.line('v')
  local lines_end   = vim.fn.line('.')

  vim.cmd(string.format(':Git blame -L%d,%d -- %%', lines_start, lines_end))
end
vim.keymap.set('v', '<leader>gb', git_blame)

-- Plugins
local plugins = {
  { 'folke/tokyonight.nvim' },
  { 'stevearc/oil.nvim' },
  { 'nvim-treesitter/nvim-treesitter', branch = 'main', lazy = false, build = ':TSUpdate' },
  { 'echasnovski/mini.nvim', version = false },
  { 'chomosuke/typst-preview.nvim' },
  { 'j-hui/fidget.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'ibhagwan/fzf-lua' },
}

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup(plugins, {})

require 'tokyonight'.setup({
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
  }
})
vim.cmd('autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE')
vim.cmd('colorscheme tokyonight')

require'nvim-treesitter'.setup {
  -- Directory to install parsers and queries to
  install_dir = vim.fn.stdpath('data') .. '/site'
}
require'nvim-treesitter'.install { 'c', 'cpp', 'python', 'json', 'yaml', 'ruby' }

require 'fzf-lua'.setup()
vim.keymap.set('n', '<leader>sg', FzfLua.live_grep)
vim.keymap.set('n', '<leader>sw', FzfLua.grep_cword)
vim.keymap.set('n', '<leader>sh', FzfLua.helptags)
vim.keymap.set('n', '<leader>ff', FzfLua.files)
vim.keymap.set('n', '<leader><leader>', FzfLua.files)
vim.keymap.set('n', '<leader>\'', FzfLua.resume)

vim.keymap.set('n', 'grr', FzfLua.lsp_references)
vim.keymap.set('n', 'grs', FzfLua.lsp_workspace_symbols)
vim.keymap.set('n', 'gd', FzfLua.lsp_definitions)
vim.keymap.set('n', 'gri', FzfLua.lsp_implementations)
vim.keymap.set('n', 'gO', FzfLua.lsp_document_symbols)

require 'mini.align'.setup()
require 'mini.completion'.setup()
require 'mini.snippets'.setup()
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

-- LSP section (leverage lsp-config for most)
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

vim.lsp.config('tailwindcss', {
  settings = {
    tailwindCSS = {
      includeLanguages = {
        htmldjango = "html",
      },
    }
  }
})

vim.lsp.enable({ 'pylsp', 'clangd', 'tailwindcss', 'lua_ls' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
