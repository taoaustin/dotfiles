return {
  {
    "snacks.nvim",
    opts = {
      indent = {
        indent = {
          hl = "MiniIndentscopeSymbol",
        },
        scope = {
          hl = "SnacksIndent",
        },
      },
    },
  },
  { "savq/melange-nvim" },
  {
    "xiantang/darcula-dark.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "everviolet/nvim",
    name = "evergarden",
    enabled = true,
    opts = {
      theme = {
        variant = "spring", -- 'winter'|'fall'|'spring'|'summer'
        accent = "green",
      },
      editor = {
        transparent_background = false,
        sign = { color = "none" },
        float = {
          color = "mantle",
          invert_border = false,
        },
        completion = {
          color = "surface0",
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        vim.cmd.colorscheme("melange")
        -- vim.cmd.colorscheme("evergarden")
        -- vim.cmd.colorscheme("darcula-dark")
        vim.cmd.highlight({ args = { "Normal", "guibg=NONE", "ctermbg=NONE" } })
        vim.cmd.highlight({ args = { "EndOfBuffer", "guibg=NONE", "ctermbg=NONE" } })
      end,
    },
  },
}
