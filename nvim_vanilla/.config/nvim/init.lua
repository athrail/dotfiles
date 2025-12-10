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
  { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
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
      terminal = { enabled = true },
    },
  },
  { 'saghen/blink.cmp', version = '1.*', opts = {} },
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

require 'nvim-treesitter-textobjects'.setup()
require'nvim-treesitter'.setup {
  -- Directory to install parsers and queries to
  install_dir = vim.fn.stdpath('data') .. '/site',
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      include_surrounding_whitespace = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
        ["]o"] = "@loop.*",
        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
        --
        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
      goto_next = {
        ["]d"] = "@conditional.outer",
      },
      goto_previous = {
        ["[d"] = "@conditional.outer",
      }
    }
  }
}
require 'nvim-treesitter'.install { 'c', 'cpp', 'python', 'json', 'yaml' }

require 'mini.align'.setup()
require 'mini.snippets'.setup()
require 'mini.trailspace'.setup()
require 'mini.statusline'.setup()
require 'mini.surround'.setup()
require 'mini.tabline'.setup()
require 'mini.pairs'.setup()
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


vim.keymap.set('n', '<leader>cr', function() Snacks.picker.lsp_references() end)
vim.keymap.set('n', '<leader>cs', function() Snacks.picker.lsp_symbols() end)
vim.keymap.set('n', '<leader>cS', function() Snacks.picker.lsp_workspace_symbols() end)
vim.keymap.set('n', '<leader>cd', function() Snacks.picker.lsp_definitions() end)
vim.keymap.set('n', '<leader>ci', function() Snacks.picker.lsp_implementations() end)

vim.keymap.set('n', '<leader>t', function() Snacks.terminal() end)
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

vim.lsp.enable({ 'pyright', 'clangd', 'tailwindcss', 'lua_ls', 'tinymist' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
