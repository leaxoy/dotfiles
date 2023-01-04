return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-path",

    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require "cmp"

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0
        and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    local feedkey = function(key, mode)
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end

    cmp.setup {
      -- completion = { completeopt = "menu,menuone,noinsert" },
      experimental = { ghost_text = true },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        ---@param entry cmp.Entry
        ---@param item vim.CompletedItem
        ---@return vim.CompletedItem
        format = function(entry, item)
          item.kind = vim.lsp.protocol.CompletionItemKind[item.kind] or item.kind
          local shorten = string.sub(item.abbr, 0, 30)
          if shorten ~= item.abbr then item.abbr = shorten .. " " end
          local completion_item = entry:get_completion_item()
          item.menu = completion_item and completion_item.detail
          return item
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-d>"] = cmp.mapping.scroll_docs(5),
        ["<C-u>"] = cmp.mapping.scroll_docs(-5),
        ["<C-Space>"] = cmp.mapping.complete { reason = cmp.ContextReason.Auto },
        ["<C-g>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
          select = true,
          behavior = cmp.ConfirmBehavior.Replace,
        },
        ["<Tab>"] = cmp.mapping {
          c = function()
            if cmp.visible() then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
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
              cmp.complete { reason = cmp.ContextReason.Auto }
            else
              fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
          end,
        },
        ["<S-Tab>"] = cmp.mapping {
          c = function()
            if cmp.visible() then
              cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
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
          end,
        },
      },
      snippet = {
        expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
      },
      sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          function(lhs, rhs)
            local _, lhs_under = lhs.completion_item.label:find "^_+"
            local _, rhs_under = rhs.completion_item.label:find "^_+"
            lhs_under = lhs_under or 0
            rhs_under = rhs_under or 0
            return lhs_under < rhs_under
          end,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "vsnip" },
        { name = "buffer" },
      },
      window = {
        completion = cmp.config.window.bordered {},
        documentation = cmp.config.window.bordered {},
      },
    }

    -- Use buffer source for `/` & `?`.
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "buffer" } },
    })

    -- Use cmdline & path source for ':'.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "path" }, { name = "cmdline" } },
    })

    cmp.setup.filetype({ "dap-repl" }, { sources = { { name = "dap" } } })

    vim.api.nvim_create_autocmd("BufRead", {
      group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
      pattern = "Cargo.toml",
      callback = function() cmp.setup.buffer { sources = { { name = "crates" } } } end,
    })
  end,
}
