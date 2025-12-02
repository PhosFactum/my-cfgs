-- "Space" button
vim.g.mapleader = " "


-- desc: description for "Which-key" utility
-- silent: key to not show :Neotree ... in cmd after typing a command


-- NeoTree
vim.keymap.set('n', '<leader>f', ':Neotree float focus<CR>', 
    { desc = "Neo-tree float focus", silent = true})
vim.keymap.set('n', '<leader>gs', ':Neotree float git_status<CR>', 
    { desc = "Neo-tree git status", silent = true })
