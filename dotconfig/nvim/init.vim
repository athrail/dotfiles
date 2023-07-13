call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'sindrets/diffview.nvim'
Plug 'TimUntersberger/neogit'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'preservim/nerdcommenter'
Plug 'williamboman/mason.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-lualine/lualine.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

call plug#end()

colorscheme catppuccin-mocha

"General setup
set number
set title
syntax enable
set fileencoding=utf-8
set encoding=utf-8

set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes
set tabstop=2
set shiftwidth=2
set expandtab
set scrolloff=8

"Changing default NERDTree arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

nnoremap <C-t> :NERDTreeToggle<CR>

nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-w> :q<CR>

"Neogit
lua require('neogit').setup()
"Mason
lua require('mason').setup()
"Lualine
lua <<EOF
  require('lualine').setup{
    options = { theme = 'dracula' }
  }
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable                     " Disable folding at startup.

"Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <C-x>a <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <C-p> :lua require"telescope.builtin".git_files{use_git_root=false, previewer=false} <CR>
nnoremap <C-x>f <CMD>Telescope current_buffer_fuzzy_find<CR>

nnoremap <C-/> <Plug>NERDCommenterToggle

filetype plugin on

autocmd BufRead,BufNewFile *.simics setfiletype perl

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local nvim_lsp = require('lspconfig')

  -- setup langs
  nvim_lsp['clangd'].setup{
    capabilities = capabilities
  }
  nvim_lsp['pyright'].setup{
    capabilities = capabilities
  }
  nvim_lsp['gopls'].setup{
    capabilities = capabilities
  }
EOF


lua <<EOF
  require'nvim-treesitter.configs'.setup{
    ensure_installed = { 'c', 'python', 'perl', 'lua', 'markdown', 'go'},
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    }
  }
EOF
