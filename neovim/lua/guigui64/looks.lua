local nnoremap = require("guigui64.map").nnoremap

-- theme
vim.opt.background = "dark"

vim.g.guigui64_colorscheme = "gruvbox-material"
vim.o.termguicolors = true
vim.g.gruvbox_material_transparent_background = 2
-- require("tokyonight").setup({
--     transparent = true,
--     styles = {
--         sidebars = "transparent",
--         floats = "transparent"
--     },
--     on_colors = function(colors)
--         colors.comment = "#868eb3"
--     end
-- })
vim.cmd("colorscheme " .. vim.g.guigui64_colorscheme)

-- statusline
require("lualine").setup({
    options = {
        component_separators = "",
        section_separators = "",
        theme = vim.g.guigui64_colorscheme,
        globalstatus = true,
    },
    sections = {
        lualine_a = { function() return string.upper(vim.api.nvim_get_mode().mode) end }, -- shorten mode
        lualine_b = { "branch", "diagnostics" },
        lualine_c = {
            {
                "filename",
                newfile_status = true,
                path = 1, -- relative path
            }
        },
        lualine_x = { "filetype" },
    }
})

-- tree
require("nvim-tree").setup({
    actions = {
        open_file = {
            window_picker = {
                enable = false
            },
            resize_window = false
        }
    }
})
nnoremap("<leader>x", ":NvimTreeFindFileToggle <CR>")
