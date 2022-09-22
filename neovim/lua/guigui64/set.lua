local o = vim.opt
local fn = vim.fn

o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = 'yes'

o.errorbells = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

o.smartindent = true

o.mouse = 'a'

o.ignorecase = true

o.hlsearch = false

o.undofile = true
o.backupdir = { fn.stdpath('data') .. '/backup' }
o.directory = { fn.stdpath('data') .. '/swap' }
o.undodir = { fn.stdpath('data') .. '/undo' }

o.list = true
o.listchars = { tab = '→ ', trail = '·' }
o.splitright = true
o.splitbelow = true

o.scrolloff = 8

o.updatetime = 50 -- for CursorHold event

vim.g.mapleader = ","
