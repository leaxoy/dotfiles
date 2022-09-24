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

vim.api.nvim_create_autocmd("Filetype", {
  pattern = {
    "dap-repl",
    "dapui_scopes",
    "dapui_breakpoints",
    "dapui_stacks",
    "dapui_watches",
    "dapui_console",
  },
  callback = function() vim.opt_local.mouse = "nvi" end,
  desc = "debug session enable mouse action"
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    local opts = {
      focusable = false,
      header = "",
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "if_many",
      prefix = "",
      scope = "cursor",
    }
    vim.diagnostic.open_float(opts)
  end,
  desc = "automatic open float diagnostic window"
})
