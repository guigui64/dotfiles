-- tree-sitter is used for better hilighting, indentation and folding
-- we only need to install the language parsers

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "go", "gomod",
        "c", "cpp",
        "bash",
        "javascript", "typescript", "json",
        "lua",
        "python",
    },
    autotag = { -- from windwp/nvim-ts-autotag plugin
        enable = true,
        filetypes = {
            'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx',
            'rescript',
            'xml',
            'php',
            'markdown',
            'glimmer', 'handlebars', 'hbs',
            'jst'
        }
    },
    highlight = { enable = true },
})
