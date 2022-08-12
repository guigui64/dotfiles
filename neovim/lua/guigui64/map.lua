local function _map(mode, opts)
    opts = opts or {noremap = true}
    return function(lhs, rhs, options)
        options = vim.tbl_extend("force", opts, options or {})
        vim.keymap.set(mode, lhs, rhs, options)
    end
end

local M = {}

M.nmap = _map("n", {noremap = false})
M.noremap = _map("")
M.nnoremap = _map("n")
M.vnoremap = _map("v")
M.xnoremap = _map("x")
M.inoremap = _map("i")

return M
