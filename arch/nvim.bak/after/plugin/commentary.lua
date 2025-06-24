if vim.loop.os_uname().sysname == "Darwin" then
    vim.keymap.set("n", "<D-/>", ":Commentary<CR>", {noremap = true})
    vim.keymap.set("i", "<D-/>", "<Esc>:Commentary<CR>a", {noremap = true})
    vim.keymap.set("v", "<D-/>", ":Commentary<CR>gv", {noremap = true})
else
    vim.keymap.set("n", "<C-/>", ":Commentary<CR>", {noremap = true})
    vim.keymap.set("i", "<C-/>", "<Esc>:Commentary<CR>a", {noremap = true})
    vim.keymap.set("v", "<C-/>", ":Commentary<CR>gv", {noremap = true})

    vim.keymap.set("n", "<C-_>", ":Commentary<CR>", {noremap = true})
    vim.keymap.set("i", "<C-_>", "<Esc>:Commentary<CR>a", {noremap = true})
    vim.keymap.set("v", "<C-_>", ":Commentary<CR>gv", {noremap = true})
end

