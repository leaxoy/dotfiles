local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("VimEnter", { command = "clearjumps" })
autocmd("VimEnter", { command = "messages clear" })

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- resize splits if window got resized
autocmd("VimResized", { command = "tabdo wincmd =" })

--#region filetype specific
autocmd("FileType", {
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
  pattern = { "qf", "help", "man", "lspsagaoutline" },
  callback = function()
    vim.bo.buflisted = false
    map_local { "q", "<CMD>q<CR>" }
  end,
})
--#endregion
