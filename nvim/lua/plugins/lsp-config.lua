return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
        require("mason-lspconfig").setup({
                ensure_installed = {"lua_ls","ts_ls","julials","pyright","clangd","cssls","marksman"},
                automatic_enable = false
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.ts_ls.setup({})
            lspconfig.julials.setup({})
            lspconfig.pyright.setup({})
            lspconfig.clangd.setup({})
            lspconfig.cssls.setup({})
            lspconfig.marksman.setup({})
            lspconfig.volar.setup({})

            vim.keymap.set('n', 'K', vim.lsp.buf.hover,{})
            vim.keymap.set('n','gd', vim.lsp.buf.definition,{})
            vim.keymap.set('n','<leader>ca', vim.lsp.buf.code_action,{})
        end
    }

}
