local saga_status, saga = pcall(require, "lspsaga")
if saga_status then
  saga.init_lsp_saga {
    border_style = "double",
    max_preview_lines = 25,
    symbol_in_winbar = {
      enable = true,
      in_custom = false,
      click_support = false,
      show_file = true,
      file_formatter = "%:.", -- relative filename
      separator = "  ",
    },
    finder_action_keys = {
      open = { "o", "<CR>" },
      quit = { "q", "<Esc>" },
      vsplit = "v",
      split = "s",
      scroll_down = "<C-d>",
      scroll_up = "<C-u>",
    },
    show_outline = { auto_enter = false, jump_key = "<CR>" },
    finder_request_timeout = 5000,
    finder_icons = { def = " ", imp = " ", ref = " " },
    rename_action_quit = "<Esc>",
    definition_action_keys = { quit = "q" },
    code_action_lightbulb = { enable = false },
    -- call_hierarchy = { show_detail = true },
  }
end

local hint_status, hint = pcall(require, "lsp-inlayhints")
if hint_status then
  hint.setup {
    inlay_hints = {
      type_hints = { prefix = " " },
      parameter_hints = { prefix = " " },
    },
  }
end

local document_color_status, document_color = pcall(require, "document-color")
if document_color_status then document_color.setup { mode = "background" } end

local glance_status, glance = pcall(require, "glance")
if glance_status then
  glance.setup {
    border = { enable = true, top_char = "─", bottom_char = "─" },
    folds = { folded = true, fold_open = "▾", fold_closed = "▸" },
    list = { position = "right", width = 0.3 },
    theme = { enable = true, mode = "auto" },
    mappings = {
      list = {
        q = glance.actions.close,
        v = glance.actions.jump_vsplit,
        s = glance.actions.jump_split,
        t = glance.actions.jump_tab,
        ["<Esc>"] = glance.actions.close,
        ["<Tab>"] = glance.actions.enter_win "preview",
        ["<CR>"] = glance.actions.jump,
      },
      preview = {
        q = glance.actions.close,
        ["<Esc>"] = glance.actions.close,
        ["<Tab>"] = glance.actions.enter_win "list",
      },
    },
    winbar = { enable = false },
    hooks = {
      ---@param results table
      ---@param open fun(table)
      ---@param jump fun(any)
      ---@param method string
      ---@diagnostic disable-next-line: unused-local
      before_open = function(results, open, jump, method)
        if #results == 1 then
          jump(results[1]) -- argument is optional
        else
          open(results) -- argument is optional
        end
      end,
    },
  }
end
