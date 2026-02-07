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
vim.keymap.set('n', '<leader>o', ':update<CR>:source<CR>', { desc = "Source current file" })
vim.keymap.set('n', '<C-s>', ':write<CR>', { desc = "Save file" })
vim.keymap.set('n', '<leader>q', ':quit<CR>', { desc = "Quit" })
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
vim.keymap.set('n', '<leader>ws', '<C-w>s<C-w>w', { desc = "Horizontal Split" })
vim.keymap.set('n', '<leader>wv', '<C-w>v<C-w>w', { desc = "Vertical Split" })
vim.keymap.set('n', '<leader>wq', '<C-w>q', { desc = "Close window" })

-- Buffer managements
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = "Kill buffer" })
vim.keymap.set('n', '<leader>bD', ':bd!<CR>', { desc = "Force kill buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Git blame for selection
local function git_blame()
  local lines_start = vim.fn.line('v')
  local lines_end   = vim.fn.line('.')

  vim.cmd(string.format(':Git blame -L%d,%d -- %%', lines_start, lines_end))
end
vim.keymap.set('v', '<leader>gb', git_blame, { desc = "Git blame selection" })

-- Plugins
local plugins = {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require 'rose-pine'.setup({
        styles = {
          italic = false,
        }
      })
      vim.cmd('autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE')
      vim.cmd("colorscheme rose-pine")
    end
  },
  { 'nvim-treesitter/nvim-treesitter', branch = 'main', lazy = false, build = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
  { 'echasnovski/mini.nvim', version = false },
  { 'chomosuke/typst-preview.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'mason-org/mason.nvim' },
  { 'saghen/blink.cmp', version = '1.*', opts = {} },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    opts = {
      sort_case_insensitive = true,
      filesystem = {
        filtered_items = {
          visible = false, -- hide filtered items on open
          hide_gitignored = true,
          hide_dotfiles = false,
          hide_by_name = {
            ".github",
            ".gitignore",
            "package-lock.json",
            ".changeset",
            ".prettierrc.json",
          },
          never_show = { ".git" },
        },
      },
    }
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  },
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed.
      -- "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
      -- "nvim-mini/mini.pick",           -- optional
      -- "folke/snacks.nvim",             -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    }
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "ej-shafran/compile-mode.nvim",
    version = "^5.0.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "m00qek/baleia.nvim", tag = "v1.3.0" },
    },
    config = function()
      ---@type CompileModeOpts
      vim.g.compile_mode = {
        -- if you use something like `nvim-cmp` or `blink.cmp` for completion,
        -- set this to fix tab completion in command mode:
        input_word_completion = true,

        -- to add ANSI escape code support, add:
        baleia_setup = true,

        -- to make `:Compile` replace special characters (e.g. `%`) in
        -- the command (and behave more like `:!`), add:
        bang_expansion = true,
      }
    end
  },
  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
      }
  }
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

require 'mini.align'.setup()
require 'mini.snippets'.setup()
require 'mini.trailspace'.setup()
require 'mini.statusline'.setup()
require 'mini.surround'.setup()
require 'mini.tabline'.setup()
require 'mini.pairs'.setup()
require 'typst-preview'.setup()

vim.keymap.set('n', '<leader>e', function() vim.cmd("Neotree current") end, { desc = "Neotree" })

local fzfl = require 'fzf-lua'
fzfl.register_ui_select()

vim.keymap.set('n', '<leader>sg', fzfl.live_grep, { desc = "Live grep" })
vim.keymap.set('n', '<leader>sG', fzfl.grep, { desc = "Grep through files" })
vim.keymap.set('n', '<leader>sw', fzfl.grep_cword, { desc = "Look for word under cursor" })
vim.keymap.set('n', '<leader>sR', fzfl.resume, { desc = "Resume last search" })
vim.keymap.set('n', '<leader>sh', fzfl.helptags, { desc = "Look through help" })

vim.keymap.set('n', '<leader>ff', fzfl.files, { desc = "Find file" })
vim.keymap.set('n', '<leader>.', fzfl.files, { desc = "Find file" })
vim.keymap.set('n', '<leader><leader>', fzfl.files, { desc = "Find file" })
vim.keymap.set('n', '<leader>fg', fzfl.git_files, { desc = "Git Files" })
vim.keymap.set('n', '<leader>,', fzfl.buffers, { desc = "Buffers" })
vim.keymap.set('n', '<leader>fb', fzfl.buffers, { desc = "Buffers" })

vim.keymap.set('n', '<leader>cr', fzfl.lsp_references, { desc = "LSP references" })
vim.keymap.set('n', '<leader>cs', fzfl.lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set('n', '<leader>cS', fzfl.lsp_workspace_symbols, { desc = "Workspace symbols" })
vim.keymap.set('n', '<leader>cd', fzfl.lsp_definitions, { desc = "Definitions" })
vim.keymap.set('n', '<leader>ci', fzfl.lsp_implementations, { desc = "Implementations" })

vim.keymap.set('n', '<leader>cc', function() vim.cmd("Compile") end, { desc = "Compile" })
vim.keymap.set('n', '<leader>cm', function() vim.cmd("Recompile") end, { desc = "Recompile" })

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

vim.lsp.enable({ 'ty', 'clangd', 'tailwindcss', 'lua_ls', 'tinymist' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
