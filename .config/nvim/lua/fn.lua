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

local hl_create = function(hl_group, hl_info)
  vim.api.nvim_set_hl(0, hl_group, hl_info)
end

local hl_link = function(hl_group, link_to)
  vim.api.nvim_set_hl(0, hl_group, { link = link_to, default = true })
end

return { lsp_notify = lsp_notify, cmd_fn = cmd_fn, hl_link = hl_link, hl_create = hl_create }
