local function vcs()
  ---@diagnostic disable-next-line: undefined-field
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then return "" end
  local added = git_info.added and ("%#GitSignsAdd#  " .. git_info.added) or ""
  local changed = git_info.changed and ("%#GitSignsChange#  " .. git_info.changed) or ""
  local removed = git_info.removed and ("%#GitSignsDelete#  " .. git_info.removed) or ""
  if git_info.added == 0 then added = "" end
  if git_info.changed == 0 then changed = "" end
  if git_info.removed == 0 then removed = "" end
  return table.concat { "%#Normal#  ", git_info.head, added, changed, removed, " %#StatusLine#" }
end

local function diagnostic()
  local function fmt(level, hl, icon)
    local count = #vim.diagnostic.get(0, { severity = level })
    return count > 0 and "%#" .. hl .. "# " .. icon .. count or ""
  end
  local severity = vim.diagnostic.severity
  return table.concat {
    fmt(severity.E, "DiagnosticError", " "),
    fmt(severity.W, "DiagnosticWarn", " "),
    fmt(severity.I, "DiagnosticInfo", " "),
    fmt(severity.N, "DiagnosticHint", " "),
    #vim.diagnostic.get(0) > 0 and " %#StatusLine#" or "",
  }
end

local function lsp()
  local clients = vim
    .iter(vim.lsp.get_active_clients { bufnr = 0 })
    :map(function(v) return v.name end)
    :totable()

  table.sort(clients)
  local client_view = table.concat(clients, " & ")
  local content = table.concat { "%#LspInfoTitle#  ", client_view, " %#StatusLine#" }
  return client_view:len() > 0 and content or ""
end

local function plugins()
  local lazy_status = require "lazy.status"
  if not lazy_status.has_updates() then return "" end
  return table.concat { "%#Normal# ", lazy_status.updates(), " Updates", " %#StatusLine#" }
end

function Stl()
  if vim.bo.buftype == "terminal" then return "%= " .. vim.o.shell .. "%=" end
  return table.concat {
    " ",
    "%h%r%w",
    vcs(),
    diagnostic(),
    "%=",
    lsp(),
    "%=",
    plugins(),
    " %l:%c  %P",
    " ",
  }
end

vim.opt.statusline = "%!v:lua.Stl()"
