-- base config --base
vim.o.mousemodel = "extend"
vim.o.updatetime = 200
vim.o.timeoutlen = 200
vim.o.clipboard = "unnamedplus"
vim.o.swapfile = false
vim.o.backup = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.splitkeep = "topline"
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.o.wrap = false
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmatch = true
-- vim.o.inccommand = "split"
vim.o.backspace = "indent,eol,start"
vim.o.sessionoptions =
  "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
vim.o.autoread = true
vim.o.confirm = true
vim.o.spelloptions = "camel,noplainbuffer"
vim.o.conceallevel = 2
vim.wo.conceallevel = 2
vim.o.concealcursor = ""

-- indent config --
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.smarttab = true
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.breakindent = true
vim.o.smartindent = true

-- fold config --
-- vim.o.foldenable = true
-- -- vim.o.foldmethod = "expr"
-- vim.o.foldmethod = "indent"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.o.foldlevel = 99
-- vim.o.foldlevelstart = 99
-- vim.o.foldcolumn = "auto"

-- ui config --
vim.o.background = "dark"
vim.o.number = true
vim.o.numberwidth = 4
vim.o.relativenumber = true
vim.o.showmode = true
vim.o.list = true
vim.o.listchars = "tab:» ,extends:›,precedes:‹,nbsp:·,trail:·,multispace: "
vim.o.fillchars = "eob: "
vim.o.showcmd = true
vim.o.wildmenu = true
vim.o.cmdheight = 0
vim.o.termguicolors = true
vim.o.laststatus = 3
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.ruler = true
vim.o.colorcolumn = "100"

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
