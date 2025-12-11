return {
  { "savq/melange-nvim" },
  { "EdenEast/nightfox.nvim" },
  { "xiantang/darcula-dark.nvim" },
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
    "ramojus/mellifluous.nvim",
    opts = {
      colorset = "mellifluous",
    },
  },
  { "ptdewey/darkearth-nvim" },
  { "xero/miasma.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        vim.cmd.colorscheme("melange")
        -- vim.cmd.colorscheme("darkearth")
        -- vim.cmd.colorscheme("miasma")
        -- vim.cmd.colorscheme("mellifluous")
        -- vim.cmd.colorscheme("terafox")
        -- vim.cmd.colorscheme("darcula-dark")
        vim.cmd.highlight({ args = { "Normal", "guibg=NONE", "ctermbg=NONE" } })
        vim.cmd.highlight({ args = { "EndOfBuffer", "guibg=NONE", "ctermbg=NONE" } })
      end,
    },
  },
}
