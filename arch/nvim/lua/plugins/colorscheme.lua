return {
  { "savq/melange-nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        vim.cmd.colorscheme("melange")
        vim.cmd.highlight({ args = { "Normal", "guibg=NONE", "ctermbg=NONE" } })
        vim.cmd.highlight({ args = { "EndOfBuffer", "guibg=NONE", "ctermbg=NONE" } })
      end,
    },
  },
}
