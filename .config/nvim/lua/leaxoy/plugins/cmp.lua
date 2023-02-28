return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      lazy = true,
      config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },
    build = "make install_jsregexp",
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<tab>",
        function() return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>" end,
        expr = true,
        silent = true,
        mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
    config = function()
      local cmd = vim.api.nvim_create_user_command
      cmd("LuaSnipEdit", require("luasnip.loaders").edit_snippet_files, { desc = "Edit Snippets" })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",

      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    event = "InsertEnter",
    config = function()
      ---@param s string
      ---@param patterns table<string>
      local function contains_any(s, patterns)
        for _, p in ipairs(patterns) do
          if type(s) == "string" and s:find(p, 1, true) then return true end
        end
        return false
      end

      local cmp = require "cmp"
      local luasnip = require "luasnip"

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s"
            == nil
      end

      cmp.setup {
        experimental = { ghost_text = true },
        formatting = {
          ---@type cmp.ItemField[]
          fields = { "kind", "abbr", "menu" },
          ---@param entry cmp.Entry
          ---@param item vim.CompletedItem
          ---@return vim.CompletedItem
          format = function(entry, item)
            item.kind = vim.lsp.protocol.CompletionItemKind[item.kind] or item.kind
            local shorten = string.sub(item.abbr, 0, 20)
            if shorten ~= item.abbr then item.abbr = shorten .. "  " end
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
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        snippet = {
          ---@param args cmp.SnippetExpansionParams
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            ---@param lhs cmp.Entry
            ---@param rhs cmp.Entry
            ---@return boolean
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
        sources = cmp.config.sources {
          {
            name = "nvim_lsp",
            ---@param entry cmp.Entry
            ---@param ctx cmp.Context
            ---@return boolean
            entry_filter = function(entry, ctx)
              local item = entry:get_completion_item()
              local ft = ctx.filetype
              local boilerplate_method =
                contains_any(item.label, { "ReadField", "FastRead", "WriteField", "FastWrite" })

              if ft == "go" and boilerplate_method then return false end
              return true
            end,
          },
          { name = "luasnip", option = { show_autosnippets = true } },
          { name = "buffer" },
          { name = "path" },
        },
        window = {
          -- completion = cmp.config.window.bordered {},
          documentation = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
          },
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
    end,
  },
}
