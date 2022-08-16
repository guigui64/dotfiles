vim.opt.background = "dark"

vim.g.guigui64_colorscheme = "tokyonight"
vim.cmd("colorscheme " .. vim.g.guigui64_colorscheme)

-- statusline
require("lualine").setup({
    options = {
        component_separators = "",
        section_separators = "",
    },
    sections = {
        lualine_a = { function() return string.upper(vim.api.nvim_get_mode().mode) end }, -- shorten mode
        lualine_b = { "branch" },
        lualine_c = { function() -- get relative path to file and shorten if too long
            local path = vim.api.nvim_eval([[fnamemodify(expand("%"), ":~:.")]])
            if (string.len(path) > 30) then
                path = vim.api.nvim_eval([[pathshorten(fnamemodify(expand("%"), ":~:."))]])
            end
            return path
        end },
        lualine_x = { "filetype" },
    }
})
