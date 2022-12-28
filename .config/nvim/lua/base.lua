-- base config --base
vim.opt.mousemodel = "extend"
vim.cmd [[aunmenu PopUp]]
vim.opt.updatetime = 200
vim.opt.timeoutlen = 200
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "topline"
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.inccommand = "nosplit"
vim.opt.backspace = "indent,eol,start"
vim.opt.sessionoptions =
  "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
vim.opt.autoread = true
vim.opt.confirm = true
vim.opt.spelloptions = "camel,noplainbuffer"
vim.opt.conceallevel = 2
vim.opt.concealcursor = ""

-- indent config --
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.smartindent = true

-- fold config --
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 99
-- vim.opt.foldcolumn = "auto"

-- ui config --
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.relativenumber = true
vim.opt.showmode = true
vim.opt.list = true
vim.opt.listchars = "tab:» ,extends:›,precedes:‹,nbsp:·,trail:·,multispace: "
vim.opt.fillchars = "eob: "
vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.cmdheight = 0
vim.opt.termguicolors = true
vim.opt.laststatus = 3
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.ruler = true
vim.opt.colorcolumn = "80"

-- keymap config --
vim.g.mapleader = " "

-- disable builtin plugins --
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
