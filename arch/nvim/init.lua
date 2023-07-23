local opt = vim.opt

-- MOST OPTIONS
opt.background="dark"
opt.termguicolors=true
opt.clipboard={"unnamedplus", "unnamed"}
opt.cursorline=true
opt.mouse="nvi"
opt.number=true
opt.title=true
opt.expandtab=true
opt.shiftwidth=4
opt.tabstop=4
opt.completeopt={"noinsert","noselect","menuone", "menu"}

-- USED FOR BOOTSTRAPPING PACKER ON FRESH CLONE/INSTALL
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1',
                   'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- LOAD PLUG-INS
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'  -- manages itself, nvim package manager
    use {
        'nvim-lualine/lualine.nvim', -- statusline
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use {
        'nvim-treesitter/nvim-treesitter', -- more syntax highlighting
        run = function()
            require('nvim-treesitter.install').update({with_sync = true})
        end
    }
    use 'neovim/nvim-lspconfig' -- allows easy LSP configuration
    use 'nvim-tree/nvim-web-devicons'
    use {
        "glepnir/lspsaga.nvim",
        branch = "main",
        requires = {
            {"nvim-tree/nvim-web-devicons"},
            --Please make sure you install markdown and markdown_inline parser
            {"nvim-treesitter/nvim-treesitter"}
        }
    }
    use 'hrsh7th/nvim-cmp' -- autocomplete
    use 'hrsh7th/cmp-nvim-lsp' -- use LSP as autocomplete source
    use 'hrsh7th/cmp-buffer' -- buffer words as cmp source
    use 'hrsh7th/cmp-cmdline' -- cmdline source
    use 'hrsh7th/cmp-path' -- path source
    use 'williamboman/mason.nvim' -- LSP package manager
    use 'williamboman/mason-lspconfig.nvim' -- mason & lspconfig integration
    use 'tpope/vim-fugitive' -- git in vim with ":Git" commands
    use 'lewis6991/gitsigns.nvim' -- git decors, see added/changed lines
    use 'L3MON4D3/LuaSnip' -- snippets
    use 'saadparwaiz1/cmp_luasnip' -- snippet autocompletion
    use 'windwp/nvim-autopairs' -- auto closing brackets + indent
    use 'petertriho/nvim-scrollbar' -- shows a scrollbar + extra
    use 'norcalli/nvim-colorizer.lua' -- highlights hex color w/ its color
    use 'marko-cerovac/material.nvim' -- colorscheme
    use 'sainnhe/everforest' -- colorscheme
    use 'sainnhe/sonokai' -- colorscheme
    use 'yonlu/omni.vim' -- colorscheme
    use 'yazeed1s/oh-lucy.nvim' --colorscheme
    use 'savq/melange-nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'romgrk/barbar.nvim', requires = 'nvim-web-devicons'} -- better tabs
    use 'tpope/vim-commentary' -- vscode-like commenting
    use 'lukas-reineke/indent-blankline.nvim' -- indentation level
    if packer_bootstrap then
        require('packer').sync() -- bootstrapping
    end
end)


-- HAXE FILETYPE
--  isn't being recognized for some reason, must add manually
vim.filetype.add({
    extension = {
        hx = "haxe"
    }
})

-- CUSTOM MAPPINGS
    -- convenient multi-line tabs
vim.api.nvim_set_keymap("v", "<Tab>", ">gv", {noremap = true})
vim.api.nvim_set_keymap("v", "<S-Tab>", "<gv", {noremap = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "<C-d>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Tab>", ">>", {noremap = true})
vim.api.nvim_set_keymap("n", "<S-Tab>", "<<", {noremap = true})
    -- for ctrl-s saves
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", {noremap = true}) 
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>", {noremap = true})
    -- for ctrl-v paste 
vim.keymap.set("n", "<C-v>", "\"+p", {noremap = true})
vim.keymap.set("i", "<C-v>", "<Esc>\"+pa", {noremap = true})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {noremap = true})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {noremap = true})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {noremap = true})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {noremap = true})

    -- for ctrl-/ commenting "_" maps to "/" for some reason
vim.keymap.set("n", "<C-_>", ":Commentary<CR>", {noremap = true})
vim.keymap.set("i", "<C-_>", "<Esc>:Commentary<CR>a", {noremap = true})
vim.keymap.set("v", "<C-_>", ":Commentary<CR>gv", {noremap = true})

    -- for lspsaga binds
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
vim.keymap.set("n","gd", "<cmd>Lspsaga goto_definition<CR>")
vim.keymap.set("n","<leader>E", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

-- SET COLORSCHEME
vim.g.material_style = "darker"
vim.g.sonokai_style = "default"
--vim.cmd 'colorscheme material'
--vim.cmd 'colorscheme oh-lucy-evening'
--vim.cmd 'colorscheme omni'
vim.cmd 'colorscheme melange'

vim.cmd 'highlight Normal guibg=NONE ctermbg=NONE' --TRANSPARENT BG
vim.cmd 'highlight EndOfBuffer guibg=None ctermbg=None' -- TRANSPARENT EOB

require("material").setup({
    lualine_style = 'stealth'
})

-- LUALINE
require('lualine').setup {
    options = {theme = 'auto'},
    extensions = {'fugitive'}
}

-- SCROLLBAR
require("scrollbar").setup()

-- TREESITTER
--  uses separate parser from https://github.com/vantreeseba/tree-sitter-haxe
--  since no support in official nvim-treesitter yet.
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.haxe = {
    install_info = {
        url = "~/repos/tree-sitter-haxe", -- local path or git repo
        files = {"src/parser.c"},
        -- optional entries:

        -- if stand-alone parser without npm dependencies
        generate_requires_npm = false,

        -- if folder contains pre-generated src/parser.c
        requires_generate_from_grammar = false,
    },
}

require('nvim-treesitter.configs').setup {
    auto_install = true, -- installs missing parser when opening filetype
    ensure_installed = {"haxe"},
    highlight = {
        enable = true
    }
}



-- AUTOPAIRS
require('nvim-autopairs').setup()

-- GITSIGNS
require('gitsigns').setup()

-- MASON 
-- mason setup must happen before lspconfig setup
require('mason').setup()
require('mason-lspconfig').setup({
    -- installs whatever is setup in lspconfig automatically
    automatic_installation = true
})

-- LSPCONFIG
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')
local servers = {"lua_ls", "tsserver", "jdtls", "ocamllsp", "clangd"}  -- SERVERS HERE
for _, server in ipairs(servers) do
    lspconfig[server].setup {
        capabilities = capabilities
    }
end
lspconfig["haxe_language_server"].setup({
    cmd = {"node", vim.fn.stdpath('data').."/mason/packages/haxe-language-server/bin/server.js"},
    capabilities = capabilities

})

-- CMP
local luasnip = require('luasnip')
local cmp = require('cmp')
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
        --['<Esc>'] = cmp.mapping.abort()
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp'},
        {name = 'luasnip'}, -- For luasnip users.
    }, {
        {name = 'buffer'},
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        {name = 'buffer'}
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        {name = 'path'}
    }, {
        {name = 'cmdline'}
    })
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

-- COLORIZER
require('colorizer').setup()

-- BARBAR
require('bufferline').setup({
    icons = { filetype = { enabled = false } }
})

require('lspsaga').setup()

-- TELESCOPE
require ('telescope').setup({
    pickers = {
        colorscheme = {
            enable_preview = true
        }
    }
})

require ('indent_blankline').setup()


