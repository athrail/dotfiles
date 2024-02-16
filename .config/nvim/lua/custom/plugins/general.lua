return {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  { 'folke/which-key.nvim', opts = {} },
  { "catppuccin/nvim",      name = "catppuccin" },
  { 'numToStr/Comment.nvim',    opts = {} },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },

  'nvimtools/none-ls.nvim',
  'MunifTanjim/prettier.nvim',

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catppuccin-mocha',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_c = { { 'filename', path = 1 }}
      }
    },
  },
}
