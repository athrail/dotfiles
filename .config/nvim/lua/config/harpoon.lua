local harpoon = require("harpoon")
-- Harpoon setup
vim.keymap.set('n', '<leader>ja', function() harpoon:list():append() end, { desc = "[A]ppend file to harpoon"})
vim.keymap.set('n', '<leader>jr', function() harpoon:list():remove() end, { desc = "[R]emove file from harpoon"})
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-A-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-A-N>", function() harpoon:list():next() end)
