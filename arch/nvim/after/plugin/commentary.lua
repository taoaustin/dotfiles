vim.keymap.set("n", "<C-/>", ":Commentary<CR>", {noremap = true})
vim.keymap.set("i", "<C-/>", "<Esc>:Commentary<CR>a", {noremap = true})
vim.keymap.set("v", "<C-/>", ":Commentary<CR>gv", {noremap = true})

