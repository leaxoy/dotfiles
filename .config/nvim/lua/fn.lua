local lsp_notify = function(client_name, msg, level, timeout, keep_fn)
  local ft = vim.api.nvim_buf_get_option(0, "filetype")
  require("notify").notify(
    client_name .. ": " .. msg,
    level,
    {
      title = "LSP on " .. ft,
      icon = "",
      timeout = timeout or 3000,
      keep = keep_fn or function() return false end,
    }
  )
end

-- cmd_fn make function that call command with args
local cmd_fn = function(cmd, args)
  return function() vim.cmd({ cmd = cmd, args = args }) end
end

local map_fn = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("keep", opts or vim.empty_dict(), { noremap = true, silent = true })
  vim.keymap.set(mode, lhs, rhs, opts)
end

return {
  lsp_notify = lsp_notify,
  cmd_fn = cmd_fn,
  map_fn = map_fn,
}
