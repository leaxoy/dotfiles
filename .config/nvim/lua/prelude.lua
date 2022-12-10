---keymap is global function add new key binding
---@param mode string|table<string>
---@param lhs string
---@param rhs function|string
---@param opts table|nil
function _G.keymap(mode, lhs, rhs, opts)
  -- mode support single char, list of single char(aka table), and string
  if type(mode) == "string" and string.len(mode) > 1 then mode = vim.split(mode, "") end
  opts = vim.tbl_extend("keep", opts or vim.empty_dict(), { noremap = true, silent = true })
  vim.keymap.set(mode, lhs, rhs, opts)
end

---show key menu in ui bottom
---@param prefix string
function _G.show_keymap(prefix)
  local status, wk = pcall(require, "which-key")
  if status then wk.show(prefix) end
end

---cmd_fn make function that call command with args
---@param cmd any
---@param args any
---@return function
function _G.cmd_fn(cmd, args)
  return function() vim.cmd { cmd = cmd, args = args } end
end

---partial is helper function
---@param fn function
---@param args any|table
---@return function
function _G.partial(fn, args)
  return function() return fn(args) end
end
