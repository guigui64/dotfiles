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
                checkThirdParty = false, -- stop asking me about configuring the workspace!!
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        }
    }
}

local no_format_on_save_clients = {
    -- web stuff is formatted with prettier, not LSP
    "emmet_ls",
    "html",
    "tsserver",
    "eslint",
    "jsonls",
    "astro",
    "svelte"
}

-- This also setups mason and mason-lspconfig
require('lsp-setup').setup({
    mappings = {
        gd = 'lua require"telescope.builtin".lsp_definitions()',
        gi = 'lua require"telescope.builtin".lsp_implementations()',
        gr = 'lua require"telescope.builtin".lsp_references()',
        ['<leader>rn'] = 'lua vim.lsp.buf.rename()',
        ['<leader>ca'] = 'lua vim.lsp.buf.code_action()',
        ['<leader>f'] = 'lua vim.lsp.buf.formatting()',
    },
    servers = {
        gopls = {},
        clangd = {},
        bashls = {},
        sumneko_lua = sumneko_config,
        pyright = {},
        -- web stuff
        astro = {},
        svelte = {},
        cssls = {
            filetypes = { "css", "sass", "scss", "less", "jst", "svelte" }
        },
        emmet_ls = {
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "jst", "svelte" }
        },
        html = {
            filetypes = { "html", "jst", "svelte" }
        },
        tailwindcss = {
            root_dir = require("lspconfig").util.root_pattern('twind.config.ts', 'tailwind.config.js',
                'tailwind.config.ts', 'postcss.config.js', 'postcss.config.ts', 'package.json', 'node_modules', '.git')
        },
        tsserver = {
            root_dir = require("lspconfig").util.root_pattern("package.json")
        },
        denols = {
            root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc")
        },
        eslint = {},
        jsonls = {},
    },
    on_attach = function(client, bufnr)
        -- format on save except for web stuff (see neoformat below)
        for _, c in ipairs(no_format_on_save_clients) do
            if c == client.name then
                return -- skip auto format for those clients
            end
        end
        require('lsp-setup.utils').format_on_save(client)

        -- add specific mappings
        if "clangd" == client.name then
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>ClangdSwitchSourceHeader<cr>',
                { noremap = true, silent = true })
        end
    end
})

-- format web files with prettier
vim.g.neoformat_only_msg_on_error = true
vim.cmd [[
    augroup web_format
        autocmd!
        autocmd BufWritePre *.tsx,*.jsx,*.ts,*.js,*.json,*.svelte,*.astro Neoformat prettier
    augroup END
]]
