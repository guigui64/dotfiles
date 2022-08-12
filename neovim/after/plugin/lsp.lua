-- lsp-setup will do all I need for me, simply specify the servers yu want and it will:
--      . setup mason-lspconfig for installing the servers
--      . setup lspconfig for each server
--      . use default mappings that seem OK for me
--
-- See available servers here: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers

-- configure lua ls for neovim (from https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua)
local sumneko_config = {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        }
    }
}

require('lsp-setup').setup({
    servers = {
        gopls = {},
        clangd = {},
        bashls = {},
        eslint = {},
        jsonls = {},
        sumneko_lua = sumneko_config,
        pyright = {},
        tsserver = {},
    }
})
