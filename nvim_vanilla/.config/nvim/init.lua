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
vim.keymap.set('n', '<C-s>', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<Esc>', ':noh<Return><Esc>', { silent = true })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Window splits and close
vim.keymap.set('n', '<leader>ws', '<C-w>s<C-w>w')
vim.keymap.set('n', '<leader>wv', '<C-w>v<C-w>w')
vim.keymap.set('n', '<leader>wq', '<C-w>q')

-- Buffer managements
vim.keymap.set('n', '<leader>bd', ':bd<CR>')
vim.keymap.set('n', '<leader>bD', ':bd!<CR>')
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

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
  { 'nvim-treesitter/nvim-treesitter', branch = 'main', lazy = false, build = ':TSUpdate' },
  { 'echasnovski/mini.nvim', version = false },
  { 'chomosuke/typst-preview.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'mason-org/mason.nvim' },
  {
    'folke/snacks.nvim',
    opts = {
      explorer = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
    },
  },
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

require 'mini.align'.setup()
require 'mini.completion'.setup()
require 'mini.snippets'.setup()
require 'mini.trailspace'.setup()
require 'mini.statusline'.setup()
require 'mini.surround'.setup()
require 'mini.tabline'.setup()
require 'typst-preview'.setup()

-- Snacks setup
vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end)

vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end)
vim.keymap.set('n', '<leader>sw', function() Snacks.picker.grep_word() end)
vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end)
vim.keymap.set('n', '<leader>sR', function() Snacks.picker.resume() end)

vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end)
vim.keymap.set('n', '<leader>fg', function() Snacks.picker.git_files() end)
vim.keymap.set('n', '<leader><leader>', function() Snacks.picker.files() end)
vim.keymap.set('n', '<leader>.', function() Snacks.picker.buffers() end)

vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end)
vim.keymap.set('n', "<leader>gb", function() Snacks.picker.git_branches() end)
vim.keymap.set('n', "<leader>gl", function() Snacks.picker.git_log() end)
vim.keymap.set('n', "<leader>gL", function() Snacks.picker.git_log_line() end)
vim.keymap.set('n', "<leader>gs", function() Snacks.picker.git_status() end)


vim.keymap.set('n', 'gr', function() Snacks.picker.lsp_references() end)
vim.keymap.set('n', '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end)
vim.keymap.set('n', '<leader>ss', function() Snacks.picker.lsp_symbols() end)
vim.keymap.set('n', 'gr', function() Snacks.picker.lsp_definitions() end)
vim.keymap.set('n', 'gI', function() Snacks.picker.lsp_implementations() end)

vim.keymap.set('n', '<C-/>', function() Snacks.terminal() end)
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true })

require 'mason'.setup()

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

vim.lsp.config('tailwindcss', {
  settings = {
    tailwindCSS = {
      includeLanguages = {
        htmldjango = "html",
      },
    }
  }
})

vim.lsp.enable({ 'pyright', 'clangd', 'tailwindcss', 'lua_ls' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
