vim.g.mapleader = " "
-- CUSTOM MAPPINGS (with default vim commands)
    -- convenient multi-line tabs
vim.keymap.set("v", "<Tab>", ">gv", {noremap = true})
vim.keymap.set("v", "<S-Tab>", "<gv", {noremap = true})
vim.keymap.set("i", "<S-Tab>", "<C-d>", {noremap = true})
vim.keymap.set("n", "<Tab>", ">>", {noremap = true})
vim.keymap.set("n", "<S-Tab>", "<<", {noremap = true})
    -- for ctrl-s saves
vim.keymap.set("n", "<C-s>", ":w<CR>", {noremap = true})
vim.keymap.set({"i", "v"}, "<C-s>", "<Esc>:w<CR>", {noremap = true})
    -- for ctrl-v paste 
vim.keymap.set("n", "<C-v>", "\"+p", {noremap = true})
vim.keymap.set("i", "<C-v>", "<Esc>\"+pa", {noremap = true})
vim.keymap.set("n", "<leader>fr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

