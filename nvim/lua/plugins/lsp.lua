return {

    -- Mason
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    -- Mason LSPconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "lua_ls" },
            })
        end,
    },
    -- LSPconfig
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            local lspconfig = require("lspconfig")
            local servers = { "pyright", "lua_ls", "ts_ls", "clangd" }

            local on_attach = function(_, _)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
                vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
                vim.keymap.set('n', 'gk', vim.lsp.buf.hover, {})
            end

            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            for _, server in ipairs(servers) do
                lspconfig[server].setup({
                    on_attach = on_attach,
                    capabilities = capabilities
                })
            end
        end,
    },
    -- Additional LSP plugins can be added here
}
