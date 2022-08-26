-- packer is used for managing plugins
-- see return statement for plugins list

-- bootstrap
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
        install_path })
    vim.cmd [[packadd packer.nvim]]
end

-- automatically sync plugins on file change
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use({
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim"
    })

    -- tpope good stuff
    use({
        "tpope/vim-fugitive", -- Git dashboard and commands
        "tpope/vim-surround", -- Surround stuff
        "tpope/vim-commentary", -- Comment stuff
        "tpope/vim-repeat", -- Repeat previous plugins commands
        "tpope/vim-eunuch", -- UNIX shell commands sugar
        "tpope/vim-abolish", -- :Abolish (instead of abbrev), :Substitute, etc.
    })

    -- Telescope: the fuzzy finder
    use("nvim-telescope/telescope.nvim")

    -- LSP: neovim has LSP builtin but we need plugons for installing/configuring language servers
    use {
        "junnplus/lsp-setup.nvim",
        requires = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        }
    }
    use("folke/trouble.nvim")

    -- Completion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "andersevenrud/cmp-tmux",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip"
        },
    }
    use("rafamadriz/friendly-snippets")

    -- Tree-sitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
    }

    -- Looks
    use("folke/tokyonight.nvim")
    use("kyazdani42/nvim-web-devicons")
    use("nvim-lualine/lualine.nvim")
    use("kyazdani42/nvim-tree.lua")

    -- Languages
    use("guigui64/vim-monkey-c")
    use("windwp/nvim-ts-autotag") -- html/xml tags autoclose/autorename (using TS)

    -- Other stuff
    use("sbdchd/neoformat")
    use({ "NvChad/nvim-colorizer.lua", config = function() require("colorizer").setup() end }) -- colorize colors
    use({ "sitiom/nvim-numbertoggle", config = function() require("numbertoggle").setup() end }) -- toggle relative numbers when it matters
    use("lukas-reineke/indent-blankline.nvim")
    use("lewis6991/gitsigns.nvim") -- Git signs, blame, etc.
    use("sheerun/vim-polyglot") -- detect more filetypes

    -- Automatically set up your configuration after cloning packer.nvim
    if Packer_bootstrap then
        require("packer").sync()
    end
end)
