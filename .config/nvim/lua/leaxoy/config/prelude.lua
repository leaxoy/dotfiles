---map is global function add new keymap
---@param keys LazyKeys
function _G.map(keys)
  local lhs = keys[1]
  local rhs = keys[2]
  if not rhs then return end
  local opts = {
    desc = keys.desc,
    noremap = keys.noremap,
    remap = keys.remap,
    expr = keys.expr,
    silent = true,
  }
  vim.keymap.set(keys.mode or "n", lhs, rhs, opts)
end

---map_local is global function add new keymap for buffer local
---if no buffer specified, use current buffer
---@param keys LazyKeys
---@param buffer integer|nil
function _G.map_local(keys, buffer)
  local lhs = keys[1]
  local rhs = keys[2]
  if not rhs then return end
  local opts = {
    desc = keys.desc,
    noremap = keys.noremap,
    remap = keys.remap,
    expr = keys.expr,
    silent = true,
    buffer = buffer or 0,
  }
  vim.keymap.set(keys.mode or "n", lhs, rhs, opts)
end

---check a plugin installed or not
---@param name string plugin name
---@return boolean
function _G.is_plugin_installed(name)
  local status, _ = pcall(require, name)
  return status
end

---check whether neovim has a feature
---@param feature string
---@return boolean
function _G.has(feature) return vim.fn.has(feature) > 0 end

---comment
---@param mode string|string[]
---@return boolean
function _G.vim_mode_in(mode)
  if type(mode) == "string" and mode:len() > 1 then mode = vim.split(mode, "") end
  ---@type string
  local vim_mode = vim.api.nvim_get_mode().mode
  ---@cast mode string[]
  for _, m in pairs(mode) do
    if vim_mode:find(m) > 0 then return true end
  end
  return false
end
