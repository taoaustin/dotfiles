capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = {
    "ts_ls",
    -- "ocamllsp",
    "clangd",
    "csharp_ls",
    "kotlin_language_server",
    "pyright",
} -- SERVERS HERE
for _, server in ipairs(servers) do
    vim.lsp.config(server, {
        capabilities = capabilities
    })
end
vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "awesome" }
            }
        }
    }
})
vim.lsp.config("roslyn", {
    capabilities = capabilities,
    settings = {
        ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true
        }
    }
})
vim.lsp.enable("roslyn")

-- vim.lsp.config("haxe_language_server", {
--     cmd = { "node", vim.fn.stdpath('data') .. "/mason/packages/haxe-language-server/bin/server.js" },
--     capabilities = capabilities
-- })

vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer,
    callback = function()
        vim.lsp.buf.format { async = true }
    end
})
