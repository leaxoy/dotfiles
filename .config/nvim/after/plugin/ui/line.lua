local fe_status, fe = pcall(require, "feline")
if not fe_status then return end

local status, symbol = pcall(require, "lspsaga.symbolwinbar")

local components = { active = {} }

---@param light string
---@param dark string
local function choice(light, dark) return vim.o.background == "light" and light or dark end

---@param opts table|nil
local function hl_fn(opts) return vim.tbl_extend("force", { bg = "NONE" }, opts or {}) end

components.active[1] = {
  {
    provider = "▊ ",
    hl = hl_fn { fg = "skyblue" },
    -- right_sep = " ",
  },
  {
    provider = "vi_mode",
    hl = function()
      return {
        name = require("feline.providers.vi_mode").get_mode_highlight_name(),
        fg = require("feline.providers.vi_mode").get_mode_color(),
        bg = "NONE",
        style = "bold",
      }
    end,
    right_sep = {
      " ",
      { str = "slant_right_2_thin", hl = hl_fn { fg = "fg" } },
    },
  },
  {
    provider = "git_branch",
    hl = hl_fn { fg = choice("black", "white"), style = "bold" },
  },
  {
    provider = "git_diff_added",
    hl = hl_fn { fg = "green" },
  },
  {
    provider = "git_diff_removed",
    hl = hl_fn { fg = "red" },
  },
  {
    provider = "git_diff_changed",
    hl = hl_fn { fg = "orange" },
  },
}

components.active[2] = {
  {
    provider = function()
      local clients = {}

      for _, client in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
        clients[#clients + 1] = client.name
      end
      table.sort(clients)

      return table.concat(clients, " & ")
    end,
    hl = hl_fn { fg = "teal" },
    icon = " ",
  },
}

components.active[3] = {
  { provider = "search_count", hl = hl_fn { fg = "lightblue" } },
  { provider = "diagnostic_errors", hl = hl_fn { fg = "red" } },
  { provider = "diagnostic_warnings", hl = hl_fn { fg = "yellow" } },
  { provider = "diagnostic_hints", hl = hl_fn { fg = "cyan" } },
  { provider = "diagnostic_info", hl = hl_fn { fg = "skyblue" } },
  {
    provider = "position",
    hl = hl_fn { fg = choice("lightgrey", "orange") },
    left_sep = { { str = " ", hl = hl_fn {} } },
    right_sep = {
      { str = " ", hl = hl_fn {} },
      { str = "slant_right_2_thin", hl = hl_fn { fg = "fg" } },
    },
  },
  { provider = "scroll_bar", hl = hl_fn { fg = "skyblue", style = "bold" } },
}

fe.setup {
  components = components,
  conditional_components = {},
  custom_providers = {},
  theme = {},
  separators = {},
  force_inactive = {},
}

local breadcrumb = {
  provider = function()
    if vim.bo.filetype == "dap-repl" then return end
    local excludes = {
      "",
      "toggleterm",
      "prompt",
      "help",
      "lspsagaoutline",
      "qf",
      "packer",
      "git",
      "neotest-summary",
      "dapui_scopes",
      "dapui_breakpoints",
      "dapui_stacks",
      "dapui_watches",
      "dapui_console",
    }
    local renamed = { tsplayground = "TreeSitter Playground" }
    if vim.api.nvim_win_get_config(0).zindex or vim.tbl_contains(excludes, vim.bo.filetype) then
      return ""
    elseif vim.tbl_contains(vim.tbl_keys(renamed), vim.bo.filetype) then
      return renamed[vim.bo.filetype]
    else
      return not status and vim.fn.bufname() or symbol:get_symbol_node() or ""
    end
  end,
}

fe.winbar.setup {
  components = { active = { { breadcrumb } } },
}