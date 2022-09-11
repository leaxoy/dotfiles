-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

return require("packer").startup({
  function(use)
    -- Packer can manage itself
    use { "wbthomason/packer.nvim" }

    -- startup
    use { "lewis6991/impatient.nvim" }
    use { "folke/which-key.nvim" }

    -- Editor enhancements
    use { "williamboman/mason.nvim", config = [[ require("mason").setup({ ui = { border = "double" } }) ]] }
    use { "williamboman/mason-lspconfig.nvim", requires = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" } }
    use { "jayp0521/mason-null-ls.nvim", requires = { "williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim" } }

    -- UI
    use "stevearc/dressing.nvim" -- ui component
    use { "NvChad/nvim-colorizer.lua" }
    use "Mofiqul/vscode.nvim" -- theme
    use "folke/tokyonight.nvim"
    use { "catppuccin/nvim", as = "catppuccin", run = ":CatppuccinCompile" }
    use {
      "nvim-neo-tree/neo-tree.nvim",
      requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim" }
    }
    use { "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" } -- buffer line
    use { "nvim-lualine/lualine.nvim", requires = "kyazdani42/nvim-web-devicons" } -- statusline
    use { "WhoIsSethDaniel/lualine-lsp-progress" }
    use "akinsho/toggleterm.nvim"
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" } -- syntax highlighting
    use { "rcarriga/nvim-notify", config = function() require("notify").setup({ background_colour = "#FFFFFF" }) end }

    -- Lang specifies
    use { "solarnz/thrift.vim", opt = true, ft = "thrift" }
    use { "saecki/crates.nvim", requires = "nvim-lua/plenary.nvim" }
    use { "krady21/compiler-explorer.nvim", requires = "nvim-lua/plenary.nvim" }

    -- Lsp config
    use { "neovim/nvim-lspconfig" }
    use { "glepnir/lspsaga.nvim", requires = "neovim/nvim-lspconfig" }
    use { "lvimuser/lsp-inlayhints.nvim" }
    use { "theHamsta/nvim-semantic-tokens" }
    use { "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp", requires = "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-buffer", requires = "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-vsnip", requires = "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-cmdline", requires = "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp-document-symbol", requires = "hrsh7th/nvim-cmp" }
    use { "onsails/lspkind-nvim", requires = "hrsh7th/nvim-cmp" }
    use { "lukas-reineke/cmp-under-comparator", requires = "hrsh7th/nvim-cmp" }
    use { "David-Kunz/cmp-npm", requires = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" } }
    use { "slyces/hierarchy.nvim", requires = "nvim-treesitter/nvim-treesitter" }
    use { "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" }
    use { "ThePrimeagen/refactoring.nvim" }
    use { "b0o/SchemaStore.nvim" }
    use { "folke/lua-dev.nvim" }

    -- Snippet config
    use { "hrsh7th/vim-vsnip" }
    use { "rafamadriz/friendly-snippets", requires = "hrsh7th/vim-vsnip" }

    -- Debug & Test
    use { "mfussenegger/nvim-dap" }
    use { "rcarriga/nvim-dap-ui", requires = "mfussenegger/nvim-dap" }
    use { "theHamsta/nvim-dap-virtual-text", requires = "mfussenegger/nvim-dap" }
    use { "Weissle/persistent-breakpoints.nvim", requires = "mfussenegger/nvim-dap" }
    use {
      "nvim-neotest/neotest",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
      },
    }
    use { "nvim-neotest/neotest-vim-test", requires = { "nvim-neotest/neotest", "vim-test/vim-test" } }
    use { "nvim-neotest/neotest-go", requires = "nvim-neotest/neotest" }
    use { "nvim-neotest/neotest-python", requires = "nvim-neotest/neotest" }
    use { "rouge8/neotest-rust", requires = "nvim-neotest/neotest" }

    -- VCS
    use { "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" }
    use { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }

    -- Code edit
    use { "windwp/nvim-autopairs" }
    use { "numToStr/Comment.nvim" }
    use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" }
    use { "famiu/bufdelete.nvim" }
    use { "ellisonleao/glow.nvim" } -- markdown render

    -- Telescope Finder
    use {
      "nvim-telescope/telescope.nvim",
      requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
    }
    -- Telescope Plugins
    use { "nvim-telescope/telescope-file-browser.nvim", requires = "nvim-telescope/telescope.nvim" }
    use { "nvim-telescope/telescope-live-grep-args.nvim", requires = "nvim-telescope/telescope.nvim" }
    use { "nvim-telescope/telescope-dap.nvim", requires = "nvim-telescope/telescope.nvim" }
    use { "nvim-telescope/telescope-packer.nvim", requires = "nvim-telescope/telescope.nvim" }
    use { "edolphin-ydf/goimpl.nvim", requires = "nvim-telescope/telescope.nvim" }
    use { "sudormrfbin/cheatsheet.nvim", requires = "nvim-telescope/telescope.nvim" }

    if packer_bootstrap then require("packer").sync() end
  end,
  config = {
    git = { clone_timeout = 300 },
    max_jobs = 25,
    compile_path = vim.fn.stdpath("config") .. "/plugin/packer_compiled.lua",
  },
})
