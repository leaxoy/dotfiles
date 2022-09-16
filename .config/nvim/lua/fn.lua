local lsp_notify = function(client_name, msg, level, timeout, keep_fn)
  require("notify").notify(
    client_name .. ": " .. msg,
    level,
    {
      title = "LSP on " .. vim.bo.filetype,
      icon = " ",
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
  -- mode support single char, list of single char(aka table), and string
  if type(mode) == "string" and string.len(mode) > 1 then mode = vim.split(mode, "") end
  opts = vim.tbl_extend("keep", opts or vim.empty_dict(), { noremap = true, silent = true })
  vim.keymap.set(mode, lhs, rhs, opts)
end

local popup_fn = function(key)
  return function()
    local status, wk = pcall(require, "which-key")
    if status then wk.show(key) end
  end
end

local term_fn = function(program)
  return function()
    local status, term = pcall(require, "toggleterm.terminal")
    if not status then return end
    local prog = term.Terminal:new {
      cmd = program,
      hidden = true,
      direction = "float",
      float_opts = { border = "double" },
    }
    prog:toggle()
  end
end

return {
  lsp_notify = lsp_notify,
  cmd_fn = cmd_fn,
  map_fn = map_fn,
  popup_fn = popup_fn,
  term_fn = term_fn,
}
