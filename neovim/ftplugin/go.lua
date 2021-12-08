-- vim.cmd 'packadd! nvim-go'
vim.opt_local.expandtab = false
-- vim.cmd [[
--     augroup GoFmt
--         autocmd!
--         autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
--     augroup END
-- ]]
