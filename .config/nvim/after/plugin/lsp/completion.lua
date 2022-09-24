local status, cmp = pcall(require, "cmp")
if not status then return end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  view = { entries = { name = "custom" } },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  completion = { completeopt = "menu,menuone,noselect" },
  experimental = { ghost_text = true, native_menu = false },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = require("lspkind").cmp_format({
      with_text = false,
      maxwidth = 50,
      menu = {
        spell = "via ",
        nvim_lsp = "via ",
        vsnip = "via ",
        buffer = "via ",
        crates = "via ",
        npm = "via ",
      },
    }),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(5),
    ["<C-u>"] = cmp.mapping.scroll_docs(-5),
    ["<C-Space>"] = cmp.mapping.complete({ reason = cmp.ContextReason.Auto }),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    ["<C-g>"] = cmp.mapping(function()
      local key = vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
      vim.api.nvim_feedkeys(vim.fn["copilot#Accept"](key), "n", true)
    end, { "i" }),
    ["<Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete({ reason = cmp.ContextReason.Auto })
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end
    }),
    ["<S-Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end,
      i = function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end
    }),
  }),
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
    end,
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find "^_+"
        local _, entry2_under = entry2.completion_item.label:find "^_+"
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" }, -- For vsnip user.
    -- { name = "buffer" },
    -- { name = "cmdline" },
    -- { name = "crates" },
    { name = "spell" },
    -- { name = "npm" },
  },
})

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
  view = { entries = { name = "wildmenu" } },
  sources = { { name = "buffer" }, { name = "nvim_lsp_document_symbol" } },
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
  view = { entries = { name = "wildmenu" } },
  sources = { { name = "path" }, { name = "cmdline" } },
})

cmp.setup.filetype({ "dap-repl" }, { sources = { { name = "dap" } } })
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "package.json",
  callback = function()
    cmp.setup.buffer({ sources = { { name = "npm" } } })
  end
})
vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
  pattern = "Cargo.toml",
  callback = function()
    cmp.setup.buffer({ sources = { { name = "crates" } } })
  end,
})
