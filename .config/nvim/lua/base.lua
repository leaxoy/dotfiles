-- base config --base
vim.o.updatetime = 250
vim.o.timeoutlen = 200
vim.o.mouse = ""
vim.o.clipboard = "unnamedplus"
vim.o.swapfile = false
vim.o.backup = false
vim.o.number = true
vim.o.numberwidth = 4
vim.o.relativenumber = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.scrolloff = 3
vim.o.wrap = false
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.smarttab = true
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.breakindent = true
vim.o.smartindent = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmatch = true
vim.o.inccommand = "split"
vim.o.backspace = "indent,eol,start"
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
vim.o.autoread = true
vim.o.confirm = true

-- ui config --
vim.o.background = "dark"
-- vim.o.pumblend = 10
-- vim.o.winblend = 10
vim.o.showmode = true
vim.o.list = false
vim.o.listchars = "tab:» ,extends:›,precedes:‹,nbsp:·,trail:·,eol:↴,space:⋅"
vim.o.showcmd = true
vim.o.wildmenu = true
-- vim.o.cmdheight = 0
vim.o.termguicolors = true
vim.o.laststatus = 3
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.ruler = true
vim.o.colorcolumn = "100"

-- netrw config --
vim.g.loaded_netrwPlugin = 1 -- disable netrw plugin
vim.g.netrw_banner = false
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 3
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 20
vim.g.netrw_list_hide = "^../"

-- keymap config --
vim.g.mapleader = " "
