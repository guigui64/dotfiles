vim.cmd [[
let g:black#settings = {
    \ 'line_length': 120
\}
augroup Black
    autocmd!
    autocmd BufWritePre *.py :silent! call BlackSync()
augroup END
]]
