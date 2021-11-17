local M = {}

local function _map(mode, noremap)
    if noremap == nil then noremap = true end
    local options = {noremap = noremap}
    return function (lhs, rhs, opts)
        if opts then options = vim.tbl_extend('force', options, opts) end
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end
end

M.noremap = _map('')
M.nnoremap = _map('n')
M.vnoremap = _map('v')
M.inoremap = _map('i')

return M
