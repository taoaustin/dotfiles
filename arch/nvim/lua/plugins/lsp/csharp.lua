return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c_sharp" } },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ensure_installed = {
        "roslyn",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        roslyn = {},
      },
      setup = {
        roslyn = function()
          return true
        end,
      },
    },
  },
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {},
  },
}
