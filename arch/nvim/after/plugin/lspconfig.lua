local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')
local servers = {
    "ts_ls",
    -- "ocamllsp",
    "clangd",
    "omnisharp",
    "kotlin_language_server",
    "pyright",
}  -- SERVERS HERE
for _, server in ipairs(servers) do
    lspconfig[server].setup {
        capabilities = capabilities
    }
end
lspconfig["lua_ls"].setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics =  {
                globals = { "vim", "awesome" }
            }
        }
    }
})
lspconfig["haxe_language_server"].setup({
    cmd = {"node", vim.fn.stdpath('data').."/mason/packages/haxe-language-server/bin/server.js"},
    capabilities = capabilities
})

