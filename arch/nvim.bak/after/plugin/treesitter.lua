--  uses separate parser from https://github.com/vantreeseba/tree-sitter-haxe
--  since no support in official nvim-treesitter yet.
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.haxe = {
  install_info = {
    url = "https://github.com/vantreeseba/tree-sitter-haxe",
    files = {"src/parser.c"},
    -- optional entries:
    branch = "main",
  },
  filetype = "haxe",
}

require('nvim-treesitter.configs').setup {
    auto_install = true, -- installs missing parser when opening filetype
    highlight = {
        enable = true
    },
    autotag = {
        enable = true
    }
}

