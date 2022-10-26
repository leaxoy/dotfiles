vim.api.nvim_create_autocmd("VimEnter", { callback = function() vim.cmd.clearjumps {} end })

vim.api.nvim_create_autocmd("Filetype", {
  pattern = {
    "c",
    "cpp",
    "go",
    "html",
    "javascriptreact",
    "javascript",
    "json",
    "kotlin",
    "lua",
    "rust",
    "typescriptreact",
    "typescript",
    "vue",
  },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
  desc = "set tabstop and shiftwidth for specific filetypes",
})
