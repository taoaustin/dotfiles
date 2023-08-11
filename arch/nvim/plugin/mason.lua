-- MASON 
-- mason setup must happen before lspconfig setup
require('mason').setup()
require('mason-lspconfig').setup({
    -- installs whatever is setup in lspconfig automatically
    automatic_installation = true
})

