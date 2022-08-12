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
