return {
  { "savq/melange-nvim" },
  {
    "xiantang/darcula-dark.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        vim.cmd.colorscheme("melange")
        -- vim.cmd.colorscheme("jb")
        -- vim.cmd.colorscheme("darcula-dark")
        vim.cmd.highlight({ args = { "Normal", "guibg=NONE", "ctermbg=NONE" } })
        vim.cmd.highlight({ args = { "EndOfBuffer", "guibg=NONE", "ctermbg=NONE" } })
      end,
    },
  },
}
