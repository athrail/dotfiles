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
  { 'nvim-treesitter/nvim-treesitter',             branch = 'main', lazy = false, build = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
  { 'nvim-mini/mini.statusline', version = false },
  { 'nvim-mini/mini.tabline', version = false },
  { 'nvim-mini/mini.pairs', version = false },
  { 'chomosuke/typst-preview.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'mason-org/mason.nvim' },
  { 'saghen/blink.cmp',                            version = '1.*', opts = {} },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false,                    -- neo-tree will lazily load itself
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
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      -- "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua",              -- optional
      -- "nvim-mini/mini.pick",           -- optional
      "folke/snacks.nvim", -- optional
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
      -- "rcarriga/nvim-notify",
    }
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },

      layout = {
        backdrop = false,
        width = 0.5,
        min_width = 80,
        height = 0.8,
        min_height = 30,
        box = "vertical",
        border = true,
        title = "{title} {live} {flags}",
        title_pos = "center",
        { win = "input",   height = 1,          border = "bottom" },
        { win = "list",    border = "none" },
        { win = "preview", title = "{preview}", height = 0.4,     border = "top" },
      },
    },
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
      { out,                            "WarningMsg" },
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
require 'nvim-treesitter'.setup {
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

require 'mini.statusline'.setup()
require 'mini.tabline'.setup()
require 'mini.pairs'.setup()
require 'typst-preview'.setup()

require 'noice'.setup {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true,         -- use a classic bottom cmdline for search
    command_palette = true,       -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },
}

vim.keymap.set('n', '<leader>e', function() vim.cmd("Neotree current") end, { desc = "Neotree" })

-- Search menu
vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end)
vim.keymap.set('n', '<leader>sw', function() Snacks.picker.grep_word() end)
vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end)
vim.keymap.set('n', '<leader>sR', function() Snacks.picker.resume() end)

-- Find menu
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end)
vim.keymap.set('n', '<leader>fg', function() Snacks.picker.git_files() end)
vim.keymap.set('n', '<leader>fb', function() Snacks.picker.buffers() end)

-- Git stuff
-- vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end)
vim.keymap.set('n', '<leader>gG', function() Snacks.lazygit() end)
vim.keymap.set('n', "<leader>gb", function() Snacks.picker.git_branches() end)
vim.keymap.set('n', "<leader>gl", function() Snacks.picker.git_log() end)
vim.keymap.set('n', "<leader>gL", function() Snacks.picker.git_log_line() end)
vim.keymap.set('n', "<leader>gs", function() Snacks.picker.git_status() end)

-- LSP stuff
vim.keymap.set('n', '<leader>cr', function() Snacks.picker.lsp_references() end)
vim.keymap.set('n', '<leader>cs', function() Snacks.picker.lsp_symbols() end)
vim.keymap.set('n', '<leader>cS', function() Snacks.picker.lsp_workspace_symbols() end)
vim.keymap.set('n', '<leader>cd', function() Snacks.picker.lsp_definitions() end)
vim.keymap.set('n', '<leader>ci', function() Snacks.picker.lsp_implementations() end)

-- Buffer managements
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = "Kill buffer" })
vim.keymap.set('n', '<leader>ba', function() Snacks.bufdelete.all() end, { desc = "Force kill buffer" })
vim.keymap.set('n', '<leader>bs', function() vim.cmd('write') end, { desc = "Save" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

vim.keymap.set('n', '<C-/>', function() Snacks.terminal() end)

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
