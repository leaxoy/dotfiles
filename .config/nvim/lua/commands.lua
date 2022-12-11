local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

--#region filetype specific
autocmd("Filetype", {
  pattern = { "go", "lua" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
  desc = "set tabstop and shiftwidth for specific filetypes",
})

autocmd("FileType", {
  desc = "Unlist quickfist buffers",
  group = augroup("unlist_quickfist", { clear = true }),
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
    buffer_keymap("n", "q", "<CMD>q<CR>")
  end,
})
--#endregion

autocmd("VimEnter", { callback = function() vim.cmd.clearjumps {} end })

autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup("highlightyank", { clear = true }),
  pattern = "*",
  callback = function() vim.highlight.on_yank() end,
})

--#region filetype detect
autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Detect thrift filetype",
  pattern = "*.thrift",
  callback = function() vim.opt_local.filetype = "thrift" end,
})
--#endregion
