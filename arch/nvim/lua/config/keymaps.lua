-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
vim.keymap.set("i", "<S-Tab>", "<C-d>", { noremap = true, silent = true })
vim.keymap.set("n", "<Tab>", ">>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true, silent = true })
if vim.uv.os_uname().sysname == "Darwin" then
  vim.keymap.set("n", "<D-s>", ":w<Cr>", { noremap = true, silent = true })
  vim.keymap.set({ "i", "v" }, "<D-s>", "<Esc>:w<Cr>", { noremap = true, silent = true })
end
