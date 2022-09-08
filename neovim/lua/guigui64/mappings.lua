-- Global mappings (not using plugins)

local noremap = require("guigui64.map").noremap
local nnoremap = require("guigui64.map").nnoremap
local vnoremap = require("guigui64.map").vnoremap
local inoremap = require("guigui64.map").inoremap

nnoremap('<leader>l', ':set list!<cr>')
nnoremap('/', '/\\v') -- very magic search
vnoremap('/', '/\\v')
noremap('<leader><space>', ':let @/=""<cr>')
noremap('j', 'gj') -- move up/down display lines
noremap('k', 'gk')
nnoremap('<leader>nn', ':set number<cr>:let &relativenumber = (&relativenumber == 1 ? 0 : 1)<cr>')
nnoremap('<leader>ev', ':split ' .. vim.env.MYVIMRC .. '<cr>')
nnoremap('<leader>sv', ':source ' .. vim.env.MYVIMRC .. '<cr>')
nnoremap('<leader>ep', ':edit ' .. vim.fn.stdpath('config') .. '/lua/guigui64/plugins.lua' .. '<cr>')
nnoremap('<leader>ws', ':write | source<cr>')
noremap('-', 'ddp')
noremap('+', 'ddkP')
nnoremap('<leader>stt', ':s/    /\t/g<cr>:let @/=""<cr>')
inoremap('{<cr>', '{<cr>}<Esc>O')
nnoremap('<leader>bg', ':let &background = ( &background == "dark"? "light" : "dark" )<CR>')
vim.cmd 'cnoreabbrev vds vertical diffsplit'
nnoremap("<C-PageDown>", ":bnext<CR>")
nnoremap("<C-PageUp>", ":bprevious<CR>")
