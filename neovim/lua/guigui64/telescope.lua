-- TELESCOPE is the fuzzy finder

local nnoremap = require("guigui64.map").nnoremap

nnoremap("<C-p>", ":lua require('telescope.builtin').builtin()<cr>")
nnoremap("<leader>tf", ":lua require('telescope.builtin').find_files()<cr>")
nnoremap("<leader>tcg", ":lua require('telescope.builtin').grep_string()<cr>")
nnoremap("<leader>tg", ":lua require('telescope.builtin').live_grep()<cr>")
nnoremap("<leader>tb", ":lua require('telescope.builtin').buffers()<cr>")
nnoremap("<leader>tc", ":lua require('telescope.builtin').commands()<cr>")
nnoremap("<leader>tm", ":lua require('telescope.builtin').keymaps()<cr>")
nnoremap("<leader>th", ":lua require('telescope.builtin').help_tags()<cr>")

-- extensions

require("telescope").setup {
    pickers = {
        buffers = {
            mappings = {
                i = {
                    ["<C-w>"] = "delete_buffer",
                    ["<C-s>"] = "toggle_selection"
                }
            }
        }
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
        }
    }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
