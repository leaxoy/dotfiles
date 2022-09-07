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

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
    vim.api.nvim_set_hl(0, "FloatTitle", { link = "Normal" })
    vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
    vim.api.nvim_set_hl(0, "LspInlayHint", { link = "Comment" })
    vim.api.nvim_set_hl(0, "LspFloatWinNormal", { link = "Normal" })
    -- vim.api.nvim_set_hl(0, "WinBar", { fg = "#458e88", undercurl = true })
    -- vim.api.nvim_set_hl(0, "WinBarNC", { fg = "#666777", undercurl = true })
    vim.api.nvim_set_hl(0, "WhichKeyFloat", { link = "Normal" })
    vim.api.nvim_set_hl(0, "LspCodeLens", { link = "WarningMsg" })
    vim.api.nvim_set_hl(0, "LspCodeLensText", { link = "WarningMsg" })
    vim.api.nvim_set_hl(0, "LspCodeLensTextSign", { link = "LspCodeLensText" })
    vim.api.nvim_set_hl(0, "LspCodeLensTextSeparator", { link = "Boolean" })
  end
})
