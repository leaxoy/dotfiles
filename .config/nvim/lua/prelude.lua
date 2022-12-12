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

---keymap is global function add new key binding for current buffer local
---@param mode string|table<string>
---@param lhs string
---@param rhs function|string
---@param buffer integer|nil
---@param opts table|nil
function _G.buffer_keymap(mode, lhs, rhs, buffer, opts)
  opts = vim.tbl_extend("keep", opts or vim.empty_dict(), { buffer = buffer or true })
  keymap(mode, lhs, rhs, opts)
end

---show key menu in ui bottom
---@param prefix string
function _G.show_keymap(prefix)
  local status, wk = pcall(require, "which-key")
  if status then wk.show(prefix) end
end

---cmd_fn make function that call command with args
---@param cmd string command name
---@param args table|nil command arguments
---@return fun()
function _G.cmd_fn(cmd, args)
  return function() vim.cmd { cmd = cmd, args = args } end
end

---partial is helper function
---@generic T: table|any
---@param fn fun(T)
---@param args T
---@return fun()
function _G.partial(fn, args)
  return function() return fn(args) end
end

---check a plugin installed or not
---@param name string plugin name
---@return boolean
function _G.is_plugin_installed(name)
  return vim.tbl_contains(vim.tbl_keys(_G.packer_plugins or {}), name)
end
