-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opt = vim.opt

if string.find(vim.fn.system("gsettings get org.gnome.desktop.interface gtk-theme"), "dark") then
  opt.background = "dark"
else
  opt.background = "light"
end

opt.wrap = true
opt.mousemodel = "extend"
