-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

return require("packer").startup {
  function(use)
    -- Packer can manage itself
    use { "wbthomason/packer.nvim" }

    -- startup
    use { "lewis6991/impatient.nvim" }
    use { "folke/which-key.nvim" }

    -- settings
    use { "folke/neoconf.nvim", requires = { "neovim/nvim-lspconfig" } }

    -- Editor enhancements
    use { "williamboman/mason.nvim" }
    use {
      "williamboman/mason-lspconfig.nvim",
      requires = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    }
    use {
      "jayp0521/mason-null-ls.nvim",
      requires = { "williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim" },
    }
    use {
      "jayp0521/mason-nvim-dap.nvim",
      requires = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    }
    use { "tamago324/nlsp-settings.nvim" }
    use { "krivahtoo/silicon.nvim", run = "./install.sh" }

    -- UI
    use { "glepnir/dashboard-nvim" } -- welcome screen
    use { "catppuccin/nvim", as = "catppuccin", run = ":CatppuccinCompile" } -- theme
    use { "folke/tokyonight.nvim" } -- theme
    use { "folke/noice.nvim", requires = { "MunifTanjim/nui.nvim" } }
    use { "nvim-lualine/lualine.nvim", requires = "nvim-tree/nvim-web-devicons" } -- statusline
    use { "akinsho/toggleterm.nvim" } -- terminal
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" } -- syntax highlighting
    use { "nvim-treesitter/playground", requires = "nvim-treesitter/nvim-treesitter" }
    use { "David-Kunz/markid", requires = "nvim-treesitter/nvim-treesitter" } -- semantic highlighting
    use { "NvChad/nvim-colorizer.lua" } -- color highlighting
    use { "rcarriga/nvim-notify" } -- notify component

    -- Lang specifies
    use { "solarnz/thrift.vim", opt = true, ft = "thrift" }
    use { "saecki/crates.nvim", requires = "nvim-lua/plenary.nvim" }
    use { "krady21/compiler-explorer.nvim", requires = "nvim-lua/plenary.nvim" }
    use { "mfussenegger/nvim-jdtls" }
    use { "simrat39/rust-tools.nvim", requires = "mattn/webapi-vim" }

    -- TextDocument Capabilities
    use { "neovim/nvim-lspconfig" } -- lsp adapters
    use { "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" } -- enchance lsp client
    use { "glepnir/lspsaga.nvim", requires = "neovim/nvim-lspconfig" }
    use { "lvimuser/lsp-inlayhints.nvim" } -- inlayHint capability
    use { "theHamsta/nvim-semantic-tokens" } -- semanticTokens capability
    use { "mrshmllow/document-color.nvim" } -- documentColor capability
    -- completion support
    use { "hrsh7th/nvim-cmp" }
    -- completion plugins
    use { "hrsh7th/cmp-nvim-lsp", requires = "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-buffer", requires = "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-cmdline", requires = "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp-document-symbol", requires = "hrsh7th/nvim-cmp" }
    use { "David-Kunz/cmp-npm", requires = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" } }
    use { "b0o/SchemaStore.nvim" }
    use { "folke/neodev.nvim" }
    -- snippet config
    use { "hrsh7th/cmp-vsnip", requires = "hrsh7th/nvim-cmp" }
    use { "rafamadriz/friendly-snippets", requires = "hrsh7th/vim-vsnip" }

    -- Debuggers
    use { "mfussenegger/nvim-dap" }
    use { "rcarriga/nvim-dap-ui", requires = "mfussenegger/nvim-dap" }
    use { "rcarriga/cmp-dap", requires = "mfussenegger/nvim-dap" }
    use { "Weissle/persistent-breakpoints.nvim", requires = "mfussenegger/nvim-dap" }
    -- Testing
    use {
      "nvim-neotest/neotest",
      requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    }
    -- testing plugins
    use {
      "nvim-neotest/neotest-vim-test",
      requires = { "nvim-neotest/neotest", "vim-test/vim-test" },
    }
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
    use { "ThePrimeagen/refactoring.nvim" }

    -- Telescope Finder
    use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } }
    -- Telescope Plugins
    use { "nvim-telescope/telescope-file-browser.nvim", requires = "nvim-telescope/telescope.nvim" }
    use { "nvim-telescope/telescope-live-grep-args.nvim", requires = "nvim-telescope/telescope.nvim" }
    use { "nvim-telescope/telescope-dap.nvim", requires = "nvim-telescope/telescope.nvim" }
    use { "nvim-telescope/telescope-ui-select.nvim", requires = "nvim-telescope/telescope.nvim" }

    if packer_bootstrap then require("packer").sync() end
  end,
  config = {
    git = { clone_timeout = 300 },
    max_jobs = 25,
    compile_path = vim.fn.stdpath "config" .. "/plugin/packer_compiled.lua",
  },
}
