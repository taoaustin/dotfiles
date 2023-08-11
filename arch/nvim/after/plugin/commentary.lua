    -- for ctrl-/ commenting "_" maps to "/" for some reason
vim.keymap.set("n", "<C-_>", ":Commentary<CR>", {noremap = true})
vim.keymap.set("i", "<C-_>", "<Esc>:Commentary<CR>a", {noremap = true})
vim.keymap.set("v", "<C-_>", ":Commentary<CR>gv", {noremap = true})

