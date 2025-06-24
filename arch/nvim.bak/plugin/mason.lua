-- MASON
-- mason setup must happen before lspconfig setup
require('mason').setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
})
require('mason-lspconfig').setup({
    -- installs whatever is setup in lspconfig automatically
    automatic_enable = true
})
