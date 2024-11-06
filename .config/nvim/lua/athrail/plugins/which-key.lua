return {
  'folke/which-key.nvim',
  dependencies = {
    "echasnovski/mini.icons"
  },
  opts = {},
  config = function() 
    local wk = require("which-key")
    wk.add {
      {"<leader>c", group = "[C]ode" },
      {"<leader>d", group = "[D]ocument"},
      {"<leader>g", group = "[G]it"},
      {"<leader>h", group = "Git [H]unk"},
      {"<leader>r", group = "[R]ename"},
      {"<leader>s", group = "[S]earch"},
      {"<leader>t", group = "[T]oggle"},
      {"<leader>w", group = "[W]orkspace"},
      {"<leader>j", group = "[J]ump with Harpoon"},
    }
    -- register which-key VISUAL mode
    -- required for visual <leader>hs (hunk stage) to work
    wk.add({
      {"<leader>", group = "VISUAL <leader>" },
      {"<leader>h", group = "Git [H]unk" },
    }, { mode = 'v' })
  end,
}
