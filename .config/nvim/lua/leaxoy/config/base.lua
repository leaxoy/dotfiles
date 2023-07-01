-- Basics config
vim.cmd [[let &t_Ce = "\e[4:0m"]]
vim.cmd [[let &t_Co = 256]]
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"]]
vim.cmd [[let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"]]

--#region base config
vim.opt.mousemodel = "extend"
vim.cmd [[aunmenu PopUp]]
vim.opt.updatetime = 200
vim.opt.timeoutlen = 200
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "topline"
vim.opt.scrolloff = 999 -- pin cursor center the screen
vim.opt.sidescrolloff = 999 -- pin cursor center the screen
vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.inccommand = "nosplit"
vim.opt.backspace = "indent,eol,start"
vim.opt.sessionoptions = "buffers,curdir,folds,help,options,tabpages,terminal,winpos,winsize"
vim.opt.autoread = true
vim.opt.confirm = true
vim.opt.spelloptions = "camel,noplainbuffer"
vim.opt.conceallevel = 3
vim.opt.concealcursor = "nvi"
vim.opt.signcolumn = "auto"
if has "nvim-0.10" then vim.opt.smoothscroll = true end
--#endregion

--#region indent config --
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.smartindent = true
--#endregion

--#region fold config
vim.opt.foldmethod = "indent"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 99
--#endregion

--#region ui config
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
vim.opt.cursorcolumn = false
vim.opt.ruler = true
vim.opt.colorcolumn = "80"
vim.opt.pumheight = 10
--#endregion

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.filetype.add { extension = { luau = "luau", thrift = "thrift", v = "v" } }
