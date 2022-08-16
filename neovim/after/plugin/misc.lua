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

-- Mappings

local nnoremap = require("guigui64.map").nnoremap

nnoremap("<leader>f", ":Neoformat<cr>")
