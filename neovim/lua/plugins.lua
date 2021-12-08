---- Bootstrap packer.nvim
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
---- Get packages
return require('packer').startup({function()
    use 'wbthomason/packer.nvim'                      -- Packer can manage itself

    use 'kyazdani42/nvim-web-devicons'                -- For all icons
    use 'nvim-lua/plenary.nvim'                       -- Lua functions used by a lot of plugins
    use 'nvim-lua/popup.nvim'                         -- Lua API for popup functionality

    -- Colors and looks
    use {'sainnhe/gruvbox-material', opt = true}      -- Better gruvbox
    use {'joshdick/onedark.vim', opt = true}          -- OneDark theme
    use 'itchyny/vim-cursorword'                      -- Underline all occurences of current word
    use {                                             -- Focus on code
        'folke/twilight.nvim',
        config = function() require('twilight').setup() end
    }

    use {                                             -- LSP clients configurations made easy
        'neovim/nvim-lspconfig',
        config = function()
            local nvim_lsp = require'lspconfig'
            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
                local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

                -- Enable completion triggered by <c-x><c-o>
                buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                local opts = { noremap=true, silent=true }

                -- See `:help vim.lsp.*` for documentation on any of the below functions
                buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
                buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
                buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
                buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
                buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
                buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
                buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
                buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
                buf_set_keymap('n', '<leader>fo', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
            end
            local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
            local servers = { 'pyright', 'gopls' }
            for _, lsp in ipairs(servers) do
                nvim_lsp[lsp].setup {
                    on_attach = on_attach,
                    capabilities = capabilities
                }
            end
        end
    }
    use {                                             -- Completion
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'andersevenrud/cmp-tmux',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip'
        },
        config = function()
            -- Setup nvim-cmp.
            local cmp = require'cmp'

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = {
                --     ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                --     ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                --     ['<C-e>'] = cmp.mapping({
                --         i = cmp.mapping.abort(),
                --         c = cmp.mapping.close(),
                --     }),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' },
                    { name = 'nvim_lua' },
                    { name = 'tmux' },
                }, {
                    { name = 'buffer' },
                })
            })

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline('/', {
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end
    }
    use {                                             -- Better syntax hi
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() -- Enable tree-sitter hilighting for maintained languages
            require('nvim-treesitter.configs').setup({
                ensure_installed = "maintained",
                highlight = { enable = true },
            })
        end
    }
    use 'nvim-telescope/telescope.nvim'               -- Fuzzy finder
    use {'nvim-telescope/telescope-fzf-native.nvim', run='make'} -- Native fzf implem
    use {                                             -- File explorer
        'kyazdani42/nvim-tree.lua',
        config = function() require('nvim-tree').setup() end
    }
    use {                                             -- Collection of mini plugins
        'echasnovski/mini.nvim',
        config = function()
            require('mini.misc').setup()              -- misc functions (put, put_text)
            require('mini.comment').setup()           -- comment stuff
            require('mini.statusline').setup()        -- simple statusline
            require('mini.starter').setup()           -- starter screen
            require('mini.surround').setup()          -- surround stuff
            require('mini.tabline').setup()           -- tabline/bufferline
        end
    }
    use {                                             -- Git decorations, blame etc.
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                current_line_blame = true -- enable git blame on current line
            })
        end
    }
    use 'tpope/vim-fugitive'                          -- Git in Vim
    use 'rbong/vim-flog'                              -- Git logs
    use 'rstacruz/vim-closer'                         -- Auto close brackets
    use {                                             -- Smooth scrolling
        'karb94/neoscroll.nvim',
        config = function() require('neoscroll').setup() end
    }
    use 'dstein64/nvim-scrollview'                    -- Emulate scrollbar
    use {                                             -- Easy toggle term
        'akinsho/toggleterm.nvim',
        config = function() require('toggleterm').setup() end
    }

    use {                                             -- Python formatting
        'averms/black-nvim',
        run = ':UpdateRemotePlugins'
    }
    use {                                             -- Go tools
        'crispgm/nvim-go',
        run = ':GoInstallBinaries',
        config = function()
            local go = require('go')
            go.setup({
                auto_lint = false
            })
            go.config.update_tool('quicktype', function(tool) tool.pkg_mgr = 'npm' end)
        end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
    -- END (don't add anything after that)
end,
config = {
    display = { log = { level = "trace" } }
}})
