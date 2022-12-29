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
        "nvim-lua/popup.nvim"
    })

    use("guigui64/local.nvim") -- secure version of 'exrc'

    -- LSP: neovim has LSP builtin but we need plugons for installing/configuring language servers
    use {
        "junnplus/lsp-setup.nvim",
    }
    use("folke/trouble.nvim")

    -- Completion
    use {
        requires = {
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip"
        },
    }
    use("rafamadriz/friendly-snippets")

    -- Tree-sitter
    use("nvim-treesitter/nvim-treesitter-context")

    -- Looks
    use("folke/tokyonight.nvim")

    -- Plugins dev
    use("rafcamlet/nvim-luapad") -- Interactive neovim scratchpad for lua

    -- Other stuff
    use("sbdchd/neoformat")
    use({ "NvChad/nvim-colorizer.lua", config = function() require("colorizer").setup({}) end }) -- colorize colors
    use({ "sitiom/nvim-numbertoggle", config = function() require("numbertoggle").setup() end }) -- toggle relative numbers when it matters
    use("lukas-reineke/indent-blankline.nvim")
    use("sheerun/vim-polyglot") -- detect more filetypes

    use("ThePrimeagen/vim-be-good")

    -- Automatically set up your configuration after cloning packer.nvim
    if Packer_bootstrap then
        require("packer").sync()
    end
end)
