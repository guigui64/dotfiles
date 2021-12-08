-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/guillaume/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/guillaume/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/guillaume/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/guillaume/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/guillaume/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["black-nvim"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/black-nvim",
    url = "https://github.com/averms/black-nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-tmux"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/cmp-tmux",
    url = "https://github.com/andersevenrud/cmp-tmux"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\2Q\0\0\2\0\4\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0B\0\2\1K\0\1\0\1\0\1\23current_line_blame\2\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gruvbox-material"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/opt/gruvbox-material",
    url = "https://github.com/sainnhe/gruvbox-material"
  },
  ["mini.nvim"] = {
    config = { "\27LJ\2\2à\1\0\0\2\0\b\0\0316\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\1\3\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\1\4\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\1\5\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\1\6\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\1\a\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\17mini.tabline\18mini.surround\17mini.starter\20mini.statusline\17mini.comment\nsetup\14mini.misc\frequire\0" },
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/mini.nvim",
    url = "https://github.com/echasnovski/mini.nvim"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\0027\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14neoscroll\frequire\0" },
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\2;\0\1\3\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\2\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvim¤\4\1\0\b\0!\0D6\0\0\0'\1\1\0B\0\2\0029\1\2\0005\2\6\0005\3\4\0003\4\3\0=\4\5\3=\3\a\0025\3\v\0009\4\b\0009\5\b\0009\5\t\5B\5\1\0025\6\n\0B\4\3\2=\4\f\0039\4\r\0009\4\14\4=\4\15\0039\4\b\0009\4\16\0045\5\17\0B\4\2\2=\4\18\3=\3\b\0029\3\r\0009\3\19\0034\4\5\0005\5\20\0>\5\1\0045\5\21\0>\5\2\0045\5\22\0>\5\3\0045\5\23\0>\5\4\0044\5\3\0005\6\24\0>\6\1\5B\3\3\2=\3\19\2B\1\2\0019\1\2\0009\1\25\1'\2\26\0005\3\28\0004\4\3\0005\5\27\0>\5\1\4=\4\19\3B\1\3\0019\1\2\0009\1\25\1'\2\29\0005\3 \0009\4\r\0009\4\19\0044\5\3\0005\6\30\0>\6\1\0054\6\3\0005\a\31\0>\a\1\6B\4\3\2=\4\19\3B\1\3\1K\0\1\0\1\0\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\6:\1\0\0\1\0\1\tname\vbuffer\6/\fcmdline\1\0\1\tname\vbuffer\1\0\1\tname\ttmux\1\0\1\tname\rnvim_lua\1\0\1\tname\nvsnip\1\0\1\tname\rnvim_lsp\fsources\t<CR>\1\0\1\vselect\2\fconfirm\n<C-y>\fdisable\vconfig\14<C-Space>\1\0\0\1\3\0\0\6i\6c\rcomplete\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0" },
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-go"] = {
    config = { "\27LJ\2\2\31\0\1\2\0\2\0\3'\1\1\0=\1\0\0K\0\1\0\bnpm\fpkg_mgrt\1\0\4\0\b\0\f6\0\0\0'\1\1\0B\0\2\0029\1\2\0005\2\3\0B\1\2\0019\1\4\0009\1\5\1'\2\6\0003\3\a\0B\1\3\1K\0\1\0\0\14quicktype\16update_tool\vconfig\1\0\1\14auto_lint\1\nsetup\ago\frequire\0" },
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/nvim-go",
    url = "https://github.com/crispgm/nvim-go"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\2A\2\0\3\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\1\0\0G\2\0\0A\0\1\1K\0\1\0\1À\24nvim_buf_set_keymap\bapi\bvimA\2\0\3\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\1\0\0G\2\0\0A\0\1\1K\0\1\0\1À\24nvim_buf_set_option\bapi\bvimÞ\n\1\2\n\0(\0o3\2\0\0003\3\1\0\18\4\3\0'\5\2\0'\6\3\0B\4\3\0015\4\4\0\18\5\2\0'\6\5\0'\a\6\0'\b\a\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\b\0'\b\t\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\n\0'\b\v\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\f\0'\b\r\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\14\0'\b\15\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\16\0'\b\17\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\18\0'\b\19\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\20\0'\b\21\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\22\0'\b\23\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\24\0'\b\25\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\26\0'\b\27\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\28\0'\b\29\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\30\0'\b\31\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a \0'\b!\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\"\0'\b#\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a$\0'\b%\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a&\0'\b'\0\18\t\4\0B\5\5\0012\0\0€K\0\1\0*<cmd>lua vim.lsp.buf.formatting()<CR>\15<leader>fo2<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>\14<leader>q0<cmd>lua vim.lsp.diagnostic.goto_next()<CR>\a]d0<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>\a[d<<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>\14<leader>e*<cmd>lua vim.lsp.buf.references()<CR>\agr+<cmd>lua vim.lsp.buf.code_action()<CR>\15<leader>ca&<cmd>lua vim.lsp.buf.rename()<CR>\15<leader>rn/<cmd>lua vim.lsp.buf.type_definition()<CR>\14<leader>DJ<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>\15<leader>wl7<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>\15<leader>wr4<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>\15<leader>wa.<cmd>lua vim.lsp.buf.signature_help()<CR>\n<C-k>.<cmd>lua vim.lsp.buf.implementation()<CR>\agi%<cmd>lua vim.lsp.buf.hover()<CR>\6K*<cmd>lua vim.lsp.buf.definition()<CR>\agd+<cmd>lua vim.lsp.buf.declaration()<CR>\agD\6n\1\0\2\vsilent\2\fnoremap\2\27v:lua.vim.lsp.omnifunc\romnifunc\0\0Ž\2\1\0\v\0\15\0\0286\0\0\0'\1\1\0B\0\2\0023\1\2\0006\2\0\0'\3\3\0B\2\2\0029\2\4\0026\3\5\0009\3\6\0039\3\a\0039\3\b\3B\3\1\0A\2\0\0025\3\t\0006\4\n\0\18\5\3\0B\4\2\4X\a\6€8\t\b\0009\t\v\t5\n\f\0=\1\r\n=\2\14\nB\t\2\1E\a\3\3R\aøK\0\1\0\17capabilities\14on_attach\1\0\0\nsetup\vipairs\1\3\0\0\fpyright\ngopls\29make_client_capabilities\rprotocol\blsp\bvim\24update_capabilities\17cmp_nvim_lsp\0\14lspconfig\frequire\0" },
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-scrollview"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/nvim-scrollview",
    url = "https://github.com/dstein64/nvim-scrollview"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\0027\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\2…\1\0\0\3\0\6\0\t6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0005\2\4\0=\2\5\1B\0\2\1K\0\1\0\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["onedark.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/opt/onedark.vim",
    url = "https://github.com/joshdick/onedark.vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\0028\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["twilight.nvim"] = {
    config = { "\27LJ\2\0026\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rtwilight\frequire\0" },
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/twilight.nvim",
    url = "https://github.com/folke/twilight.nvim"
  },
  ["vim-closer"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/vim-closer",
    url = "https://github.com/rstacruz/vim-closer"
  },
  ["vim-cursorword"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/vim-cursorword",
    url = "https://github.com/itchyny/vim-cursorword"
  },
  ["vim-flog"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/vim-flog",
    url = "https://github.com/rbong/vim-flog"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/guillaume/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: neoscroll.nvim
time([[Config for neoscroll.nvim]], true)
try_loadstring("\27LJ\2\0027\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14neoscroll\frequire\0", "config", "neoscroll.nvim")
time([[Config for neoscroll.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\2Q\0\0\2\0\4\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0B\0\2\1K\0\1\0\1\0\1\23current_line_blame\2\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\2A\2\0\3\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\1\0\0G\2\0\0A\0\1\1K\0\1\0\1À\24nvim_buf_set_keymap\bapi\bvimA\2\0\3\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\1\0\0G\2\0\0A\0\1\1K\0\1\0\1À\24nvim_buf_set_option\bapi\bvimÞ\n\1\2\n\0(\0o3\2\0\0003\3\1\0\18\4\3\0'\5\2\0'\6\3\0B\4\3\0015\4\4\0\18\5\2\0'\6\5\0'\a\6\0'\b\a\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\b\0'\b\t\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\n\0'\b\v\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\f\0'\b\r\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\14\0'\b\15\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\16\0'\b\17\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\18\0'\b\19\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\20\0'\b\21\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\22\0'\b\23\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\24\0'\b\25\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\26\0'\b\27\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\28\0'\b\29\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\30\0'\b\31\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a \0'\b!\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a\"\0'\b#\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a$\0'\b%\0\18\t\4\0B\5\5\1\18\5\2\0'\6\5\0'\a&\0'\b'\0\18\t\4\0B\5\5\0012\0\0€K\0\1\0*<cmd>lua vim.lsp.buf.formatting()<CR>\15<leader>fo2<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>\14<leader>q0<cmd>lua vim.lsp.diagnostic.goto_next()<CR>\a]d0<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>\a[d<<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>\14<leader>e*<cmd>lua vim.lsp.buf.references()<CR>\agr+<cmd>lua vim.lsp.buf.code_action()<CR>\15<leader>ca&<cmd>lua vim.lsp.buf.rename()<CR>\15<leader>rn/<cmd>lua vim.lsp.buf.type_definition()<CR>\14<leader>DJ<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>\15<leader>wl7<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>\15<leader>wr4<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>\15<leader>wa.<cmd>lua vim.lsp.buf.signature_help()<CR>\n<C-k>.<cmd>lua vim.lsp.buf.implementation()<CR>\agi%<cmd>lua vim.lsp.buf.hover()<CR>\6K*<cmd>lua vim.lsp.buf.definition()<CR>\agd+<cmd>lua vim.lsp.buf.declaration()<CR>\agD\6n\1\0\2\vsilent\2\fnoremap\2\27v:lua.vim.lsp.omnifunc\romnifunc\0\0Ž\2\1\0\v\0\15\0\0286\0\0\0'\1\1\0B\0\2\0023\1\2\0006\2\0\0'\3\3\0B\2\2\0029\2\4\0026\3\5\0009\3\6\0039\3\a\0039\3\b\3B\3\1\0A\2\0\0025\3\t\0006\4\n\0\18\5\3\0B\4\2\4X\a\6€8\t\b\0009\t\v\t5\n\f\0=\1\r\n=\2\14\nB\t\2\1E\a\3\3R\aøK\0\1\0\17capabilities\14on_attach\1\0\0\nsetup\vipairs\1\3\0\0\fpyright\ngopls\29make_client_capabilities\rprotocol\blsp\bvim\24update_capabilities\17cmp_nvim_lsp\0\14lspconfig\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: nvim-go
time([[Config for nvim-go]], true)
try_loadstring("\27LJ\2\2\31\0\1\2\0\2\0\3'\1\1\0=\1\0\0K\0\1\0\bnpm\fpkg_mgrt\1\0\4\0\b\0\f6\0\0\0'\1\1\0B\0\2\0029\1\2\0005\2\3\0B\1\2\0019\1\4\0009\1\5\1'\2\6\0003\3\a\0B\1\3\1K\0\1\0\0\14quicktype\16update_tool\vconfig\1\0\1\14auto_lint\1\nsetup\ago\frequire\0", "config", "nvim-go")
time([[Config for nvim-go]], false)
-- Config for: twilight.nvim
time([[Config for twilight.nvim]], true)
try_loadstring("\27LJ\2\0026\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rtwilight\frequire\0", "config", "twilight.nvim")
time([[Config for twilight.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\2;\0\1\3\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\2\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvim¤\4\1\0\b\0!\0D6\0\0\0'\1\1\0B\0\2\0029\1\2\0005\2\6\0005\3\4\0003\4\3\0=\4\5\3=\3\a\0025\3\v\0009\4\b\0009\5\b\0009\5\t\5B\5\1\0025\6\n\0B\4\3\2=\4\f\0039\4\r\0009\4\14\4=\4\15\0039\4\b\0009\4\16\0045\5\17\0B\4\2\2=\4\18\3=\3\b\0029\3\r\0009\3\19\0034\4\5\0005\5\20\0>\5\1\0045\5\21\0>\5\2\0045\5\22\0>\5\3\0045\5\23\0>\5\4\0044\5\3\0005\6\24\0>\6\1\5B\3\3\2=\3\19\2B\1\2\0019\1\2\0009\1\25\1'\2\26\0005\3\28\0004\4\3\0005\5\27\0>\5\1\4=\4\19\3B\1\3\0019\1\2\0009\1\25\1'\2\29\0005\3 \0009\4\r\0009\4\19\0044\5\3\0005\6\30\0>\6\1\0054\6\3\0005\a\31\0>\a\1\6B\4\3\2=\4\19\3B\1\3\1K\0\1\0\1\0\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\6:\1\0\0\1\0\1\tname\vbuffer\6/\fcmdline\1\0\1\tname\vbuffer\1\0\1\tname\ttmux\1\0\1\tname\rnvim_lua\1\0\1\tname\nvsnip\1\0\1\tname\rnvim_lsp\fsources\t<CR>\1\0\1\vselect\2\fconfirm\n<C-y>\fdisable\vconfig\14<C-Space>\1\0\0\1\3\0\0\6i\6c\rcomplete\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\0027\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\0028\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\2…\1\0\0\3\0\6\0\t6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0005\2\4\0=\2\5\1B\0\2\1K\0\1\0\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: mini.nvim
time([[Config for mini.nvim]], true)
try_loadstring("\27LJ\2\2à\1\0\0\2\0\b\0\0316\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\1\3\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\1\4\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\1\5\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\1\6\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\1\a\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\17mini.tabline\18mini.surround\17mini.starter\20mini.statusline\17mini.comment\nsetup\14mini.misc\frequire\0", "config", "mini.nvim")
time([[Config for mini.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
