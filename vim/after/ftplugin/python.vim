nnoremap <leader>pp :! python3 %<CR>
nnoremap <leader>pa :! python3 % 
nmap <leader>pi <leader>tb<CR>python<CR>

augroup Black
    au!
    au BufWritePre *.py Black
augroup END
