-- HELPERS
local cmd = vim.cmd  -- to execute Vim commands
local fn = vim.fn    -- to call Vim functions
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

-- PLUGINS {{{
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

    -- Colors and looks
    {'sainnhe/gruvbox-material', opt=true};        -- Better gruvbox
    {'joshdick/onedark.vim', opt=true};            -- OneDark theme
    'itchyny/vim-cursorword';                      -- Underline all occurences of current word
    'folke/twilight.nvim';                         -- Focus on code

    'neovim/nvim-lspconfig';                       -- LSP clients configurations made easy
    {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}; -- Better syntax hi
    'nvim-telescope/telescope.nvim';               -- Fuzzy finder
    {'nvim-telescope/telescope-fzf-native.nvim', run='make'}; -- Native fzf implem
    'kyazdani42/nvim-tree.lua';                    -- File explorer
    'echasnovski/mini.nvim';                       -- Collection of plugins (loaded below)
    'lewis6991/gitsigns.nvim';                     -- Git decorations, blame etc.
    'tpope/vim-fugitive';                          -- Git in Vim
    'rbong/vim-flog';                              -- Git logs
    'rstacruz/vim-closer';                         -- Auto close brackets

    {'psf/black', opt=true};                       -- Python formatting (TODO packadd! when ft==py)
    {'ray-x/go.nvim', opt=true};                   -- Go tools (TODO packadd! when ft==go)

}
---- Setup plugins
require'twilight'.setup{}
require'lspconfig'.gopls.setup{}                   -- TODO move to ft specific
require'lspconfig'.pyright.setup{}                 -- idem
require'nvim-treesitter.configs'.setup {           -- Enable tree-sitter hilighting for maintained languages
    ensure_installed = "maintained",
    highlight = { enable = true },
}
require'nvim-tree'.setup{}
require'mini.misc'.setup{}                         -- misc functions (put, put_text)
require'mini.comment'.setup{}                      -- comment stuff
require'mini.completion'.setup{}                   -- LSP and fallback completions
require'mini.statusline'.setup{}                   -- simple statusline
require'mini.starter'.setup{}                      -- starter screen
require'mini.surround'.setup{}                     -- surround stuff
require'mini.tabline'.setup{}                      -- tabline/bufferline
require'gitsigns'.setup{current_line_blame=true}   -- enable git blame on current line
-- PLUGINS END }}}

-- OPTIONS {{{
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
-- OPTIONS END }}}

-- MAPPINGS {{{
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
map.noremap('-', 'ddp')                                               -- move one line down
map.noremap('+', 'ddkP')                                              -- move one line up
map.noremap('<leader>stt', ':s/    /\t/g<cr>:let @/=""<cr>')          -- replace spaces by tabs
map.inoremap('{<cr>', '{<cr>}<Exc>O')                                 -- auto close {
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
-- MAPPINGS END }}}

-- LOOKS {{{
opt.background = 'dark'
opt.termguicolors = true
g.gruvbox_material_current_word = 'underline'
cmd 'packadd! onedark.vim'    -- load colorscheme autoload vimscript before setting it
cmd 'colorscheme onedark'
-- LOOKS END }}}

-- AUTOCOMMANDS {{{
cmd 'autocmd! BufWritePost $MYVIMRC source $MYVIMRC'
-- AUTOCOMMANDS END }}}
