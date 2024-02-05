
return {
    {"neovim/nvim-lspconfig",
        event = "VeryLazy",
        -- ft = {"rust", "go", "lua"},
        dependencies = { "folke/neodev.nvim"},
        config = function()
            require("neodev").setup({})

            local lspconfig = require("lspconfig")

            -- go install golang.org/x/tools/gopls@latest
            lspconfig.gopls.setup{}
            -- see https://rustup.rs/
            lspconfig.rust_analyzer.setup{}

            lspconfig.lua_ls.setup{}

            lspconfig.ols.setup{}

            -- add a border to lsp and diagnostics floating windows
            local _border = "single"
            local h = vim.lsp.handlers
            h["textDocument/hover"] = vim.lsp.with(h.hover, {border=_border})
            h["textDocument/signatureHelp"] = vim.lsp.with(h.signature_help, {border=_border})

            vim.diagnostic.config{float={border=_border}}
        end
    },

    {"hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {"hrsh7th/cmp-buffer"},
            {"hrsh7th/cmp-path"},
            {"hrsh7th/cmp-nvim-lsp"},
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-l>'] = {i = cmp.mapping.confirm({ select = false })},
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                window = { documentation = {border="single"} }
            })
        end
    },
}
