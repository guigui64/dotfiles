-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'andersevenrud/cmp-tmux',
      'hrsh7th/cmp-nvim-lua',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
      -- 'hrsh7th/cmp-vsnip',
      -- 'hrsh7th/vim-vsnip'
    },
  }

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use 'rbong/vim-flog'

  use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  use 'sainnhe/gruvbox-material' -- Gruvbox with TS
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'nvim-tree/nvim-web-devicons' -- Fancy icons
  use 'nvim-tree/nvim-tree.lua' -- Files tree
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use 'tpope/vim-surround' -- Surround stuff
  use 'tpope/vim-repeat' -- Repeat previous plugins commands
  use 'tpope/vim-eunuch' -- UNIX shell commands sugar
  use 'tpope/vim-abolish' -- :Abolish (instead of abbrev), :Substitute, etc.
  use 'matze/vim-move' -- move line/selection with <A-h/j/k/l>
  use 'AndrewRadev/switch.vim' -- use gs to switch true<->false, &&<->||, etc.
  use 'will133/vim-dirdiff' -- diff dirs
  use 'nvim-treesitter/nvim-treesitter-context' -- stick current function/context on first line
  use 'NvChad/nvim-colorizer.lua' -- colorize colors

  -- Do I need those?
  -- use 'nvim-lua/popup.nvim'
  -- use 'guigui64/local.nvim' -- secure version of 'exrc'
  -- use 'folke/trouble.nvim' -- pretty list of diagnostics, references, telescope results, quickfix and location lists
  -- use 'rafamadriz/friendly-snippets'
  -- use 'rafcamlet/nvim-luapad' -- Interactive neovim scratchpad for lua
  -- use 'sbdchd/neoformat'
  -- use { 'sitiom/nvim-numbertoggle', config = function() require('numbertoggle').setup() end } -- toggle relative numbers when it matters
  -- use 'sheerun/vim-polyglot' -- detect more filetypes

  -- Languages stuff
  use 'guigui64/vim-monkey-c'
  use 'windwp/nvim-ts-autotag' -- html/xml tags autoclose/autorename (using TS)
  use 'wuelnerdotexe/vim-astro' -- astro syntax

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
  use 'nvim-telescope/telescope-ui-select.nvim'

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Change default tabstop from 8 to 4 (even though sleuth will automatically detect the right value in most cases)
vim.o.tabstop = 4

-- Save undo history
vim.o.undofile = true
vim.fn.system { 'mkdir', '-p', vim.fn.stdpath('data') .. '/backup' }
vim.opt.backupdir = { vim.fn.stdpath('data') .. '/backup' }
vim.fn.system { 'mkdir', '-p', vim.fn.stdpath('data') .. '/swap' }
vim.opt.directory = { vim.fn.stdpath('data') .. '/swap' }
vim.fn.system { 'mkdir', '-p', vim.fn.stdpath('data') .. '/undo' }
vim.opt.undodir = { vim.fn.stdpath('data') .. '/undo' }

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 50
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.g.guigui64_colorscheme = "gruvbox-material"
vim.o.termguicolors = true
vim.g.gruvbox_material_transparent_background = 0
vim.cmd("colorscheme " .. vim.g.guigui64_colorscheme)

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.wo.cursorline = true
vim.o.smartindent = true
vim.o.list = true
vim.opt.listchars = { tab = '→ ', trail = '·' }
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 10

-- Plugins specific variables
vim.g.astro_typescript = "enable"

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set({ 'n', 'v' }, '/', '/\\v', {})
vim.keymap.set('v', '<', '<gv', {})
vim.keymap.set('v', '>', '>gv', {})
vim.keymap.set('n', '<leader>l', ':set list!<cr>', {})
vim.keymap.set('n', '<leader><space>', ':let @/=""<cr>', {})
vim.keymap.set('n', '<leader>nn', ':set number<cr>:let &relativenumber = (&relativenumber == 1 ? 0 : 1)<cr>', {})
vim.keymap.set('n', '<leader>ev', ':split ' .. vim.env.MYVIMRC .. '<cr>', {})
vim.keymap.set('n', '<leader>ws', ':write | source<cr>', {})
vim.keymap.set('n', '<leader>nw', ':noa w<cr>', {})
vim.keymap.set('n', '<leader>stt', ':s/    /\t/g<cr>:let @/=""<cr>', {})
vim.keymap.set('i', '{<cr>', '{<cr>}<Esc>O', {})
vim.keymap.set('n', '<leader>bg', ':let &background = (&background == "dark"? "light" : "dark")<CR>', {})
vim.cmd 'cnoreabbrev vds vertical diffsplit'
vim.keymap.set('n', "<C-PageDown>", ":bnext<CR>", {})
vim.keymap.set('n', "<C-PageUp>", ":bprevious<CR>", {})
vim.keymap.set('n', "<C-d>", "<C-d>zz", {}) -- center after C-d/u
vim.keymap.set('n', "<C-u>", "<C-u>zz", {})
vim.keymap.set('x', "<leader>p", "\"_dP", {}) -- paste without messing with 'clipboard'
vim.keymap.set('n', "<leader>gx", ":vertical :Flogsplit -all<CR>", {}) -- paste without messing with 'clipboard'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Looks settings (lualine, tree, etc.) ]]

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    component_separators = "",
    section_separators = "",
    theme = vim.g.guigui64_colorscheme,
    globalstatus = true,
  },
  sections = {
    lualine_a = { function() return string.upper(vim.api.nvim_get_mode().mode) end }, -- shorten mode
    -- lualine_b = { "branch", "diagnostics" },
    lualine_c = {
      {
        "filename",
        newfile_status = true,
        path = 1, -- relative path
      }
    },
    -- lualine_x = { function()
    --   local sf = require("local_nvim").sourced_file
    --   if sf then
    --     return "[" .. sf .. "]"
    --   end
    --   return ""
    -- end, "filetype" },
  }
}

-- Nvim tree
require("nvim-tree").setup({
  actions = {
    open_file = {
      window_picker = {
        enable = false
      },
      resize_window = false
    }
  },
  view = {
    adaptive_size = true,
  },
  renderer = {
    icons = {
      git_placement = "after"
    }
  }
})
vim.keymap.set('n', "<leader>x", ":NvimTreeFindFileToggle <CR>")

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  show_trailing_blankline_indent = false,
  show_current_context = true,
  show_current_context_start = true,
}

require('colorizer').setup({})

-- Other settings are set in after/plugin/init.lua for performances

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
