-- HELPERS
local cmd = vim.cmd  -- to execute Vim commands
local fn = vim.fn    -- to call Vim functions
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

-- GLOBAL CONF
---- Use virtual env for neovim. Run this:
---- $ mkdir -p ~/.local/venv && cd ~/.local/venv
---- $ python3 -m venv nvim
---- $ cd nvim
---- $ . ./bin/activate
---- $ pip install pynvim black
g.python3_host_prog = vim.env.HOME .. '/.local/venv/nvim/bin/python'

-- PLUGINS
require('plugins')
---- Auto configure packer
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

-- OPTIONS
opt.autowrite = true
opt.secure = true
opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.wildmode = {'longest', 'list', 'full'}
opt.wildmenu = true
opt.signcolumn = 'yes'
opt.path:append({'**'})
opt.textwidth = 110
opt.formatoptions = 'cqrn1'
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.mouse = 'a'
opt.scrolloff = 3
opt.matchpairs:append({'<:>'})
cmd 'runtime! macros/matchit.vim'
opt.undofile = true
opt.backupdir = {fn.stdpath('data') .. '/backup'} -- special directories
opt.directory = {fn.stdpath('data') .. '/swap'}
opt.undodir = {fn.stdpath('data') .. '/undo'}
opt.listchars = {tab = '→ ', trail = '·'}    -- visualize special characters
opt.list = true                              -- to enable previous option
opt.splitright = true                        -- split vertically to the right (default is left)
opt.splitbelow = true                        -- split horizontally to the bottom (default is top)
opt.grepprg = 'rg --vimgrep --smart-case --follow'
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true
opt.foldmethod = 'marker'

-- MAPPINGS
local map = require 'mapfns'
g.mapleader = ','
map.nnmapleader('l', ':set list!<cr>')           -- toggle on/off listchars
map.nnoremap('/', '/\\v')                        -- very magic search
map.vnoremap('/', '/\\v')
map.noremap('<leader><space>', ':let @/=""<cr>')
map.nnoremap('j', 'gj')                          -- move up/down display lines
map.nnoremap('k', 'gk')
map.nnmapleader('nn', ':set number<cr>:let &relativenumber = (&relativenumber == 1 ? 0 : 1)<cr>') -- toggle relative line numbers
map.nnmapleader('ev', ':split ' .. vim.env.MYVIMRC .. '<cr>')         -- edit config file
map.nnmapleader('sv', ':source ' .. vim.env.MYVIMRC .. '<cr>')        -- source config file
map.nnmapleader('ep', ':split ' .. vim.fn.stdpath('config') .. '/lua/plugins.lua' .. '<cr>') -- edit plugins config file
map.noremap('-', 'ddp')                                               -- move one line down
map.noremap('+', 'ddkP')                                              -- move one line up
map.noremap('<leader>stt', ':s/    /\t/g<cr>:let @/=""<cr>')          -- replace spaces by tabs
map.inoremap('{<cr>', '{<cr>}<Esc>O')                                 -- auto close {
map.nnmapleader('bg', ':let &background = ( &background == "dark"? "light" : "dark" )<CR>') -- switch bg color
map.inoremap('<c-space>', '<c-x><c-o>')                               -- omni completion
-- ?vim.api.nvim_set_keymap('i', '<c-@>', '<c-space>')
cmd 'cnoreabbrev vds vertical diffsplit'
map.nnoremap('<c-p>', '<cmd>Telescope<cr>')
map.nnmapleader('ff', '<cmd>Telescope find_files<cr>')
map.nnmapleader('fg', '<cmd>Telescope live_grep<cr>')
map.nnmapleader('fb', '<cmd>Telescope buffers<cr>')
map.nnmapleader('fh', '<cmd>Telescope help_tags<cr>')
map.nnmapleader('fm', '<cmd>Telescope keymaps<cr>')
map.nnmapleader('gb', '<cmd>Gitsigns toggle_current_line_blame<cr>')
map.nnmapleader('tt', '<cmd>NvimTreeToggle<cr>')
map.nnmapleader('tw', '<cmd>Twilight<cr>')

-- LOOKS
opt.background = 'dark'
opt.termguicolors = true
g.gruvbox_material_current_word = 'underline'
cmd 'packadd! gruvbox-material'    -- load colorscheme autoload vimscript before setting it
cmd 'colorscheme gruvbox-material'
-- cmd 'packadd! onedark.vim'    -- load colorscheme autoload vimscript before setting it
-- cmd 'colorscheme onedark'

-- AUTOCOMMANDS
cmd 'autocmd! BufWritePost $MYVIMRC source $MYVIMRC'
