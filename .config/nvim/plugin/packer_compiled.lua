-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

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
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/bytedance/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/bytedance/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/bytedance/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/bytedance/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/bytedance/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
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
  ["Comment.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  ["SchemaStore.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/SchemaStore.nvim",
    url = "https://github.com/b0o/SchemaStore.nvim"
  },
  ["bufdelete.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/bufdelete.nvim",
    url = "https://github.com/famiu/bufdelete.nvim"
  },
  ["bufferline.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  catppuccin = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["cheatsheet.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cheatsheet.nvim",
    url = "https://github.com/sudormrfbin/cheatsheet.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-npm"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cmp-npm",
    url = "https://github.com/David-Kunz/cmp-npm"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-document-symbol"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-document-symbol",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol"
  },
  ["cmp-under-comparator"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cmp-under-comparator",
    url = "https://github.com/lukas-reineke/cmp-under-comparator"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["compiler-explorer.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/compiler-explorer.nvim",
    url = "https://github.com/krady21/compiler-explorer.nvim"
  },
  ["crates.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/crates.nvim",
    url = "https://github.com/saecki/crates.nvim"
  },
  ["dashboard-nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/dashboard-nvim",
    url = "https://github.com/glepnir/dashboard-nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["document-color.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/document-color.nvim",
    url = "https://github.com/mrshmllow/document-color.nvim"
  },
  ["dressing.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["glow.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/glow.nvim",
    url = "https://github.com/ellisonleao/glow.nvim"
  },
  ["goimpl.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/goimpl.nvim",
    url = "https://github.com/edolphin-ydf/goimpl.nvim"
  },
  ["hierarchy.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/hierarchy.nvim",
    url = "https://github.com/slyces/hierarchy.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp-inlayhints.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/lsp-inlayhints.nvim",
    url = "https://github.com/lvimuser/lsp-inlayhints.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["lualine-lsp-progress"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/lualine-lsp-progress",
    url = "https://github.com/WhoIsSethDaniel/lualine-lsp-progress"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  markid = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/markid",
    url = "https://github.com/David-Kunz/markid"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason-null-ls.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/mason-null-ls.nvim",
    url = "https://github.com/jayp0521/mason-null-ls.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neo-tree.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  neotest = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/neotest",
    url = "https://github.com/nvim-neotest/neotest"
  },
  ["neotest-go"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/neotest-go",
    url = "https://github.com/nvim-neotest/neotest-go"
  },
  ["neotest-python"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/neotest-python",
    url = "https://github.com/nvim-neotest/neotest-python"
  },
  ["neotest-rust"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/neotest-rust",
    url = "https://github.com/rouge8/neotest-rust"
  },
  ["neotest-vim-test"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/neotest-vim-test",
    url = "https://github.com/nvim-neotest/neotest-vim-test"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/NvChad/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\22background_colour\f#FFFFFF\nsetup\vnotify\frequire\0" },
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-semantic-tokens"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/nvim-semantic-tokens",
    url = "https://github.com/theHamsta/nvim-semantic-tokens"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["persistent-breakpoints.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/persistent-breakpoints.nvim",
    url = "https://github.com/Weissle/persistent-breakpoints.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["refactoring.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/refactoring.nvim",
    url = "https://github.com/ThePrimeagen/refactoring.nvim"
  },
  ["telescope-dap.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/telescope-dap.nvim",
    url = "https://github.com/nvim-telescope/telescope-dap.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-live-grep-args.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/telescope-live-grep-args.nvim",
    url = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim"
  },
  ["telescope-packer.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/telescope-packer.nvim",
    url = "https://github.com/nvim-telescope/telescope-packer.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["thrift.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/opt/thrift.vim",
    url = "https://github.com/solarnz/thrift.vim"
  },
  ["todo-comments.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["toggleterm.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/vim-test",
    url = "https://github.com/vim-test/vim-test"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  ["vscode.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/vscode.nvim",
    url = "https://github.com/Mofiqul/vscode.nvim"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/Users/bytedance/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\22background_colour\f#FFFFFF\nsetup\vnotify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType thrift ++once lua require("packer.load")({'thrift.vim'}, { ft = "thrift" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/bytedance/.local/share/nvim/site/pack/packer/opt/thrift.vim/ftdetect/thrift.vim]], true)
vim.cmd [[source /Users/bytedance/.local/share/nvim/site/pack/packer/opt/thrift.vim/ftdetect/thrift.vim]]
time([[Sourcing ftdetect script at: /Users/bytedance/.local/share/nvim/site/pack/packer/opt/thrift.vim/ftdetect/thrift.vim]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
