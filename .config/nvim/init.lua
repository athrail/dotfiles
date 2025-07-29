vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.o.clipboard = "unnamedplus"
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 30
vim.o.cursorline = true
vim.o.completeopt = "menu,menuone,noinsert"


vim.keymap.set('n', '<leader>o', ':update<CR>:source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<Esc>', ':noh<Return><Esc>', { silent = true })

vim.keymap.set('n', '<leader>sv', '<C-w>v')
vim.keymap.set('n', '<leader>sh', '<C-w>s')
vim.keymap.set('n', '<leader>sh', '<C-w>q')
vim.keymap.set('n', '<leader>se', '<C-w>=')

vim.keymap.set({'n','v','x'}, '<leader>y', '"+y<CR>')
vim.keymap.set({'n','v','x'}, '<leader>d', '"+d<CR>')

vim.keymap.set('n', '<leader>rb', ':Git blame<CR>')

vim.pack.add({
  { src = 'https://github.com/rose-pine/neovim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/echasnovski/mini.icons' },
  { src = 'https://github.com/folke/which-key.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/mbbill/undotree' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  { src = 'https://github.com/tpope/vim-fugitive' },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
local client = vim.lsp.get_client_by_id(ev.data.client_id)
if client:supports_method('textDocument/completion') then
vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
end
end,
})
vim.cmd("set completeopt+=noselect")

require "rose-pine".setup({
  styles = { italic = false },
})
vim.cmd("colorscheme rose-pine")

require "nvim-treesitter.configs".setup({
  ensure_installed = { "c", "cpp", "python", "json", "yaml" },
  highlight = { enable = true }
})

require "telescope".setup({
  defaults = {
    layout_strategy = 'vertical',
    -- causes a problem when telescope is started
    -- mappings = {
    --   ["<C-a>"] = require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist,
    --   ["<C-q>"] = require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist,
    -- }
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
local tele_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', tele_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', tele_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader><space>', tele_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', tele_builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>\'', tele_builtin.resume)

vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>')

require "oil".setup({
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },
  view_options = {
    show_hidden = true,
    case_insensitive = true,
  }
})
vim.keymap.set('n', '<leader>e', ':Oil<CR>')

vim.lsp.config.clangd = {
  cmd = {
    'clangd',
    '--background-index',
    '--offset-encoding=utf-8',
  },
  root_markers = { '.clangd', 'compile_commands.json' },
  filetypes = { 'c', 'cpp' },
}
vim.lsp.config('pylsp', {})

vim.lsp.enable({ "pylsp", "clangd" })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>ld', tele_builtin.diagnostics)

require "which-key".setup()
require "lualine".setup({
  options = {
    icons_enabled = true,
    theme = 'rose-pine',
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_b = { },
    lualine_c = { { 'filename', path = 1 } }
  }
})
