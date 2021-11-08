-- HELPERS
local cmd = vim.cmd  -- to execute Vim commands
local fn = vim.fn    -- to call Vim functions
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- PLUGINS
---- Bootstrap paq-nvim
local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end
---- Get packages
require 'paq' {
    'savq/paq-nvim';                  -- Let Paq manage itself

    'nvim-lua/plenary.nvim';          -- Lua functions used by a lot of plugins
    'neovim/nvim-lspconfig';          -- LSP clients configurations made easy
    'nvim-telescope/telescope.nvim';  -- Fuzzy finder (TODO native fzf?)
    'wellle/tmux-complete.vim';       -- tmux integration in completion lists
    'tpope/vim-fugitive';             -- Git in Vim
    'rbong/vim-flog';                 -- Git log in Vim
    'tpope/vim-sensible';             -- T. Pope settings
    'tpope/vim-surround';             -- Surround stuff
    'tpope/vim-commentary';           -- Comment stuff

    'NLKNguyen/papercolor-theme';     -- Looks
    'vim-airline/vim-airline';
    'vim-airline/vim-airline-themes';
}


-- OPTIONS
cmd 'filetype off'
cmd 'filetype plugin indent on'
cmd 'syntax on'
opt.autowrite = true
opt.secure = true
opt.number = true
opt.relativenumber = false
opt.ruler = true
opt.laststatus = 2
opt.showmode = true
opt.showcmd = true
opt.wildmode = {'longest', 'list', 'full'}
opt.wildmenu = true
opt.signcolumn = 'yes'
opt.path:append({'**'})
opt.encoding = 'utf-8'
opt.wrap = true
opt.textwidth = 110
opt.formatoptions = 'cqrn1'
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.mouse = 'a'
opt.scrolloff = 3
opt.backspace = {'indent', 'eol', 'start' }
opt.matchpairs:append({'<:>'})
cmd 'runtime! macros/matchit.vim'
opt.hidden = true
opt.ttyfast = true
opt.undofile = true
opt.backupdir = {fn.stdpath('data') .. '/backup'} -- special directories
opt.directory = {fn.stdpath('data') .. '/swap'}
opt.undodir = {fn.stdpath('data') .. '/undo'}
opt.listchars = {tab = '→ ', trail = '·'}    -- visualize special characters
opt.list = true                              -- to enable previous option
opt.splitright = true                        -- split vertically to the right (default is left)
opt.splitbelow = true                        -- split horizontally to the bottom (default is top)
opt.grepprg = 'rg --vimgrep --smart-case --follow'
opt.hlsearch = true                          -- search options
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true

-- MAPPINGS
g.mapleader = ','
map('n', '<leader>l', ':set list!<cr>')      -- toggle on/off listchars
map('n', '/', '/\\v')                        -- very magic search
map('v', '/', '/\\v')
map('', '<leader><space>', ':let @/=""<cr>')
map('n', 'j', 'gj')                          -- move up/down display lines
map('n', 'k', 'gk')
map('n', '<leader>nn', ':set number<cr>:let &relativenumber = (&relativenumber == 1 ? 0 : 1)<cr>') -- toggle relative line numbers
map('n', '<leader>ev', ':split ' .. vim.env.MYVIMRC .. '<cr>')    -- edit config file
map('n', '<leader>sv', ':source ' .. vim.env.MYVIMRC .. '<cr>')   -- source config file
map('', '-', 'ddp')                                               -- move one line down
map('', '+', 'ddkP')                                              -- move one line up
map('', '<leader>stt', ':s/    /\t/g<cr>:let @/=""<cr>')          -- replace spaces by tabs
map('i', '{<cr>', '{<cr>}<Exc>O')                                 -- auto close {
map('n', '<leader>bg', ':let &background = ( &background == "dark"? "light" : "dark" )<CR>') -- switch bg color
map('i', '<c-space>', '<c-x><c-o>')                               -- omni completion
-- ?vim.api.nvim_set_keymap('i', '<c-@>', '<c-space>')
cmd 'cnoreabbrev vds vertical diffsplit'

-- LOOKS
opt.background = 'light'
opt.termguicolors = true
cmd 'colorscheme PaperColor'
cmd [[
let g:airline_theme = 'papercolor'
let g:airline#extensions#obsession#enabled = 1
autocmd VimEnter * AirlineRefresh
let g:airline_section_y = '%{airline#util#wrap(airline#parts#filetype(),0)}'
let g:airline_section_x = ''
let g:airline_section_z = '%p%% %l:%c'
]]
