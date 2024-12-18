return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua",              -- optional
    "echasnovski/mini.pick",         -- optional
  },
  config = function()
    vim.keymap.set('n', '<leader>gg', "<cmd>Neogit<CR>", { desc = "Open Neogit" })
    vim.keymap.set('n', '<leader>gl', "<cmd>NeogitLogCurrent<CR>", { desc = "Open Neogit log for current buffer" })
  end
}
