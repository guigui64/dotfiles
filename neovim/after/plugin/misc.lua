-- Miscellaneous plugins setup

require("indent_blankline").setup({
    show_current_context = true,
})

require("gitsigns").setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        map('n', '<leader>gb', gs.toggle_current_line_blame)
    end
})

require('Comment').setup()

-- Mappings

local nnoremap = require("guigui64.map").nnoremap

nnoremap("<leader>f", ":Neoformat<cr>")

-- Netrw (made obsolete by nvim-tree)

vim.g.netrw_liststyle = 3 -- tree mode
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4 -- open in previous window
