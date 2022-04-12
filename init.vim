set background=dark
set termguicolors
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
"set mouse=a
set number
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu
set wildchar=<Tab>
set expandtab
set shiftwidth=4
set tabstop=4
set autoindent
set hlsearch
syntax enable
set t_Co=256
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

call plug#begin()
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'tpope/vim-fugitive'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'morhetz/gruvbox'
    Plug 'neovim/nvim-lspconfig'
    Plug 'tami5/lspsaga.nvim'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
call plug#end()


nnoremap <silent> <CR> o<Esc>
nnoremap <silent> <S-Enter> O<Esc>

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

augroup cringe_ass_terminal_transparency
    autocmd!
    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
augroup END

colorscheme gruvbox

autocmd VimLeave * set guicursor=a:ver25

lua << EOF
    require('lualine').setup {
        options = { theme = 'gruvbox' }, --"auto"
        extensions = { 'fugitive' }
    }
    
    require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",
        highlight = {
            enable = true
        },
    }

    local luasnip = require('luasnip') 
    local cmp = require('cmp')
    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
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
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        },
    }    

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    
    local lspconfig = require('lspconfig')
	" REMEBER TO INSTALL LANGAUGE SERVERS THROUGH NPM (pyright, tsserver) APT-GET (clangd) OR MANUALLY (jdtls)
    local servers = {'pyright', 'tsserver', 'clangd', 'jdtls'}
    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            capabilities = capabilities
        }
    end

    local saga = require('lspsaga')
    saga.setup {}
    





EOF
