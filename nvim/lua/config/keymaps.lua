-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local CoreUtil = require("lazy.core.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- ---@param option string
-- ---@param silent boolean
-- ---@param values string[]
-- local function rotate(option, silent, values)
--   for i = 1, #values do
--     if vim.opt_local[option]:get() == values[i] then
--       vim.opt_local[option] = values[(i + 1) % #values]
--       if silent then
--         return Util.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
--       else
--         return
--       end
--     end
--   end
-- end

-- stylua: ignore start

map("n", "<leader>bg", function() Util.toggle("background", false, { "dark", "light" }) end, { desc = "Toggle background" })

map("n", "<leader>ul", function()
  -- nonu/nornu -> nu/nornu -> nu/rnu
  local nu = vim.opt_local["number"]:get()
  local rnu = vim.opt_local["relativenumber"]:get()
  if not nu and not rnu then
    vim.opt_local["number"] = true
    vim.opt_local["relativenumber"] = false
    return CoreUtil.info("Set line numbering to normal", { title = "Option" })
  elseif nu and not rnu then
    vim.opt_local["number"] = true
    vim.opt_local["relativenumber"] = true
    return CoreUtil.info("Set line numbering to relative numbers", { title = "Option" })
  else
    vim.opt_local["number"] = false
    vim.opt_local["relativenumber"] = false
    return CoreUtil.info("Set line numbering to none", { title = "Option" })
  end
end, { desc = "Rotate lines numbering" })

-- stylua: ignore end
