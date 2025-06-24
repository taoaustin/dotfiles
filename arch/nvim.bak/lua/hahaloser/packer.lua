-- we don't need to load this code every time we open vim, just when we're planning on installing more plugins
-- just source this file (:so) when needed, then we run :PackerSync
-- if packer isn't installed (initial setup) we can download it from:
--[[
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
--]]

-- LOAD PLUG-INS

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'     -- manages itself, nvim package manager
    use {
        'nvim-lualine/lualine.nvim', -- statusline
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use {
        'nvim-treesitter/nvim-treesitter', -- more syntax highlighting
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use 'neovim/nvim-lspconfig' -- allows easy LSP configuration
    use 'nvim-tree/nvim-web-devicons'
    use {
        'nvimdev/lspsaga.nvim',
        after = 'nvim-lspconfig',
        config = function()
            require('lspsaga').setup({
                lightbulb = {
                    virtual_text = false,
                    enable_in_insert = false
                }
            })
        end,
    }
    use 'hrsh7th/nvim-cmp'                              -- autocomplete
    use 'hrsh7th/cmp-nvim-lsp'                          -- use LSP as autocomplete source
    use 'hrsh7th/cmp-buffer'                            -- buffer words as cmp source
    use 'hrsh7th/cmp-cmdline'                           -- cmdline source
    use 'hrsh7th/cmp-path'                              -- path source
    use 'L3MON4D3/LuaSnip'                              -- snippets
    use 'saadparwaiz1/cmp_luasnip'                      -- snippet autocompletion
    use 'williamboman/mason.nvim'                       -- LSP package manager
    use 'williamboman/mason-lspconfig.nvim'             -- mason & lspconfig integration
    use 'tpope/vim-fugitive'                            -- git in vim with ":Git" commands
    use 'lewis6991/gitsigns.nvim'                       -- git decors, see added/changed lines
    use 'windwp/nvim-autopairs'                         -- auto closing brackets + indent
    use 'windwp/nvim-ts-autotag'                        -- auto closing tags (html+)
    use 'petertriho/nvim-scrollbar'                     -- shows a scrollbar + extra
    use 'norcalli/nvim-colorizer.lua'                   -- highlights hex color w/ its color
    use 'marko-cerovac/material.nvim'                   -- colorscheme
    use 'sainnhe/everforest'                            -- colorscheme
    use 'savq/melange-nvim'                             -- colorscheme
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2', --fzf very cool NEED TO INSTALL RIPGREP
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 'romgrk/barbar.nvim', requires = 'nvim-web-devicons' } -- better tabs
    use 'tpope/vim-commentary'                                   -- vscode-like commenting
    use 'lukas-reineke/indent-blankline.nvim'                    -- indentation level
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    use 'mfussenegger/nvim-jdtls' --java language server
    use 'scalameta/nvim-metals'   -- scala language server
    use {
        "seblyng/roslyn.nvim",    -- c# language server
    }
end)
