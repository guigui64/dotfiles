local o = vim.opt

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2

vim.cmd [[
    augroup js_fmt
        autocmd!
        autocmd BufWritePre * undojoin | Neoformat
    augroup END
]]
