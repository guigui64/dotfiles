-- HELPERS
local cmd = vim.cmd  -- to execute Vim commands
local fn = vim.fn    -- to call Vim functions
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

-- PLUGINS
---- Bootstrap paq-nvim
local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end
---- Get packages
require 'paq' {
    'savq/paq-nvim';                               -- Let Paq manage itself

    'kyazdani42/nvim-web-devicons';                -- For all icons
    'nvim-lua/plenary.nvim';                       -- Lua functions used by a lot of plugins

    {'morhetz/gruvbox', opt=true};                 -- Colors and looks
    'itchyny/vim-cursorword';

    'neovim/nvim-lspconfig';                       -- LSP clients configurations made easy
    'nvim-telescope/telescope.nvim';               -- Fuzzy finder
    {'nvim-telescope/telescope-fzf-native.nvim', run='make'}; -- Native fzf implem
    'echasnovski/mini.nvim';                       -- Collection of plugins (loaded below)

    'lewis6991/gitsigns.nvim';                     -- Git decorations, blame etc.
    'tpope/vim-fugitive';                          -- Git in Vim
    'rbong/vim-flog';                              -- Git log in Vim

    {'psf/black', opt=true};                       -- Python formatting (TODO packadd! when ft==py)
    {'ray-x/go.nvim', opt=true};                   -- Go tools (TODO packadd! when ft==go)

}
-- Mini submodules
require'mini.misc'.setup{}        -- misc functions (put, put_text)
require'mini.comment'.setup{}     -- comment stuff
require'mini.completion'.setup{}  -- LSP and fallback completions
require'mini.statusline'.setup{}  -- simple statusline
require'mini.starter'.setup{}     -- starter screen
require'mini.surround'.setup{}    -- surround stuff
require'mini.tabline'.setup{}     -- tabline/bufferline

-- Git signs
require'gitsigns'.setup{current_line_blame=true}

-- LSP configs
require'lspconfig'.gopls.setup{}
require'lspconfig'.pyright.setup{}

-- OPTIONS
cmd 'filetype off'
cmd 'filetype plugin indent on'
cmd 'syntax on'
opt.autowrite = true
opt.secure = true
opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.ruler = true
opt.laststatus = 2
opt.showmode = false
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
local map = require 'mapfns'
g.mapleader = ','
map.nnoremap('<leader>l', ':set list!<cr>')      -- toggle on/off listchars
map.nnoremap('/', '/\\v')                        -- very magic search
map.vnoremap('/', '/\\v')
map.noremap('<leader><space>', ':let @/=""<cr>')
map.nnoremap('j', 'gj')                          -- move up/down display lines
map.nnoremap('k', 'gk')
map.nnoremap('<leader>nn', ':set number<cr>:let &relativenumber = (&relativenumber == 1 ? 0 : 1)<cr>') -- toggle relative line numbers
map.nnoremap('<leader>ev', ':split ' .. vim.env.MYVIMRC .. '<cr>')    -- edit config file
map.nnoremap('<leader>sv', ':source ' .. vim.env.MYVIMRC .. '<cr>')   -- source config file
map.noremap('-', 'ddp')                                               -- move one line down
map.noremap('+', 'ddkP')                                              -- move one line up
map.noremap('<leader>stt', ':s/    /\t/g<cr>:let @/=""<cr>')          -- replace spaces by tabs
map.inoremap('{<cr>', '{<cr>}<Exc>O')                                 -- auto close {
map.nnoremap('<leader>bg', ':let &background = ( &background == "dark"? "light" : "dark" )<CR>') -- switch bg color
map.inoremap('<c-space>', '<c-x><c-o>')                               -- omni completion
-- ?vim.api.nvim_set_keymap('i', '<c-@>', '<c-space>')
cmd 'cnoreabbrev vds vertical diffsplit'
-- Telescope mappings
map.nnoremap('<c-p>', '<cmd>Telescope<cr>')
map.nnoremap('<leader>ff', '<cmd>Telescope find_files<cr>')
map.nnoremap('<leader>fg', '<cmd>Telescope live_grep<cr>')
map.nnoremap('<leader>fb', '<cmd>Telescope buffers<cr>')
map.nnoremap('<leader>fh', '<cmd>Telescope help_tags<cr>')
-- Git signs
map.nnoremap('<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<cr>')


-- LOOKS
opt.background = 'dark'
opt.termguicolors = true
cmd 'colorscheme gruvbox'
cmd 'highlight clear CursorLine' -- only highlight the cursor line NUMBER
cmd 'highlight CursorLineNr ctermbg=NONE guibg=NONE'

-- Autocommands
cmd 'autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $NVIMRC"'
