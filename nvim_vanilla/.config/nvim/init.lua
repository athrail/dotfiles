local vim = vim

-- General options
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
vim.o.scrolloff = 5
vim.o.cursorline = true
vim.o.completeopt = "menu,menuone,noinsert"
vim.o.termguicolors = true

-- Diagnostics configuration
vim.diagnostic.config({
  underline = true,
  signs = true,
  virtual_lines = false,
  virtual_text = true,
})

-- General keymap
vim.keymap.set("n", "<leader>o", function()
  vim.cmd("update")
  vim.cmd("source")
end, { desc = "Source current file" })
vim.keymap.set("n", "<leader>q", function() vim.cmd("quit") end, { desc = "Quit" })
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<Esc>", ":noh<Return><Esc>", { silent = true })
vim.keymap.set("n", "<C-s>", function() vim.cmd("write") end, { desc = "Save" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Window splits and close
vim.keymap.set("n", "<leader>ws", "<C-w>s<C-w>w", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>wv", "<C-w>v<C-w>w", { desc = "Vertical Split" })
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Close window" })


-- Git blame for selection
local function git_blame()
  local lines_start = vim.fn.line("v")
  local lines_end   = vim.fn.line(".")

  vim.cmd(string.format(":Git blame -L%d,%d -- %%", lines_start, lines_end))
end
vim.keymap.set("v", "<leader>gb", git_blame, { desc = "Git blame selection" })

-- Plugins
vim.pack.add({
  { src = "https://github.com/Mofiqul/dracula.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  { src = "https://github.com/nvim-mini/mini.statusline" },
  { src = "https://github.com/nvim-mini/mini.tabline" },
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/chomosuke/typst-preview.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/saghen/blink.cmp", version = "v1" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = "v3.x" },
  { src = "https://github.com/NeogitOrg/neogit" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/sindrets/diffview.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
})

vim.cmd("colorscheme dracula")

-- Plugins
require "neo-tree".setup({
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
})

require "nvim-treesitter-textobjects".setup()
require "nvim-treesitter".setup {
  -- Directory to install parsers and queries to
  install_dir = vim.fn.stdpath("data") .. "/site",
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
        -- Below example nvim-treesitter"s `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
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

require "mini.statusline".setup()
require "mini.tabline".setup()
require "mini.pairs".setup()
require "typst-preview".setup()
require "mason".setup()
require "fzf-lua".setup({
  winopts = {
    preview = {
      vertical = "up:r0%",
      layout = "vertical"
    }
  }
})

vim.keymap.set("n", "<leader>E", function() vim.cmd("Neotree current reveal_file=%") end, { desc = "Neotree" })
vim.keymap.set("n", "<leader>e", function() vim.cmd("Neotree current ") end, { desc = "Neotree" })

-- Search menu
vim.keymap.set("n", "<leader>sg", FzfLua.live_grep)
vim.keymap.set("n", "<leader>sw", FzfLua.grep_cword)
vim.keymap.set("n", "<leader>sh", FzfLua.helptags)
vim.keymap.set("n", "<leader>sR", FzfLua.resume)
vim.keymap.set("n", "<leader>sm", FzfLua.manpages)
vim.keymap.set("n", "<leader>sk", FzfLua.keymaps)

-- Find menu
vim.keymap.set("n", "<leader>ff", FzfLua.files)
vim.keymap.set("n", "<leader>fg", FzfLua.git_files)
vim.keymap.set("n", "<leader>fb", FzfLua.buffers)

-- Git stuff
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Show Neogit UI" })

-- LSP stuff
vim.keymap.set("n", "<leader>cr", FzfLua.lsp_references)
vim.keymap.set("n", "<leader>cs", FzfLua.lsp_document_symbols)
vim.keymap.set("n", "<leader>cS", FzfLua.lsp_workspace_symbols)
vim.keymap.set("n", "<leader>cd", FzfLua.lsp_definitions)
vim.keymap.set("n", "<leader>ci", FzfLua.lsp_implementations)
vim.keymap.set("n", "<leader>cu", FzfLua.lsp_document_diagnostics)
vim.keymap.set("n", "<leader>cU", FzfLua.lsp_workspace_diagnostics)

-- Buffer managements
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)


-- LSP section (leverage lsp-config for most)
vim.lsp.config.clangd = {
  cmd = {
    "clangd",
    "--clang-tidy",
    "--background-index",
    "--offset-encoding=utf-8",
  },
  root_markers = { ".clangd", "compile_commands.json" },
  filetypes = { "c", "cpp" },
}

vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      includeLanguages = {
        htmldjango = "html",
      },
    }
  }
})

vim.lsp.enable({ "ty", "clangd", "tailwindcss", "lua_ls", "tinymist", "ts_ls", "emmet_language_server" })
