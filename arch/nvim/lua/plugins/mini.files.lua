return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = true,
      },
    },
  },
  {
    "nvim-mini/mini.files",
    lazy = false,
    opts = {
      options = {
        use_as_default_explorer = false,
      },
    },
  },
}
