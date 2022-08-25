vim.api.nvim_create_autocmd("Filetype", {
  pattern = {
    -- "go",
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
  command = "setlocal tabstop=2 shiftwidth=2 expandtab",
  desc = "set tabstop and shiftwidth for specific filetypes",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf = args.buf

    require("lsp").activate(client, buf)
  end,
  desc = "setup lsp functions"
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
