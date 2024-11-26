--[[
=============================================
============= CODING PLUGINS ================
=============================================

This file hosts all plugins needed to handle every day tasks
including but not limited to auto-completion, pairing, surround ...

Plugins:
  1. nvim-cmp
  2. LuaSnip
  3. mini.comment
  4. nvim-ts-context-commentstring
  5. mini.ai
  6. mini.pairs
  7. nvim-ts-autotag
  8. mini.surround

--]]

return {
  ------------------------------------------------------
  -- nvim-cmp
  -- https://github.com/hrsh7th/nvim-cmp
  --
  -- Completion engine that ships with several sources
  -- including snippets, LSP, buffers, ...
  ------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        -- stylua: ignore
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          ["<C-CR>"] = function(fallback) cmp.abort() fallback() end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require("cmp").setup(opts)
    end,
  },

  ------------------------------------------------------
  -- LuaSnip
  -- https://github.com/L3MON4D3/LuaSnip
  --
  -- By far the easiest and most resourceful plugin
  -- to handle snippets I've found to integrate with cmp.
  ------------------------------------------------------
  {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows"))
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    -- stylua: ignore
    keys = {
      -- {
      --   "<tab>",
      --   function()
      --     return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
      --   end,
      --   expr = true, silent = true, mode = "i",
      -- },
      -- { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      -- { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },

  -----------------------------------------------------------------
  -- nvim-ts-context-commentstring
  -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
  --
  -- Essential when commenting within an embedded language e.g. vue, svelte, ... It uses
  -- treesitter queries to check the location of the cursor in the file.
  -----------------------------------------------------------------
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },

  ---------------------------------------------
  -- mini.comment
  -- https://github.com/echasnovski/mini.comment
  --
  -- Comment lines with gcc, gc} ...
  ---------------------------------------------
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },

  --------------------------------------------
  -- mini.ai
  -- https://github.com/echasnovski/mini.ai
  --
  -- Extend and create a/i textobjects
  --------------------------------------------
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      }
    end,
  },

  -------------------------------------------
  -- mini.pairs
  -- https://github.com/echasnovski/mini.pairs
  --
  -- Pairing e.g [], {}, <>, ''...
  -------------------------------------------
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>up",
        function()
          local Util = require("lazy.core.util")
          vim.g.minipairs_disable = not vim.g.minipairs_disable
          if vim.g.minipairs_disable then
            Util.warn("Disabled auto pairs", { title = "Option" })
          else
            Util.info("Enabled auto pairs", { title = "Option" })
          end
        end,
        desc = "Toggle auto pairs",
      },
    },
  },

  --------------------------------------------------
  -- nvim-ts-autotag
  -- https://github.com/windwp/nvim-ts-autotag
  --
  -- Automatically add closing tags for HTML and JSX
  --------------------------------------------------
  {
    "windwp/nvim-ts-autotag",
    event = "LazyFile",
    opts = {
      autotag = {
        enable_close_on_slash = false,
      },
    },
  },

  ----------------------------------------------------
  -- mini.surround
  -- https://github.com/echasnovski/mini.surround
  --
  -- A few keymaps that make it much easier to
  -- interact with surrounding characters e.g. '"[{}]"'
  ----------------------------------------------------
  {
    "echasnovski/mini.surround",
    event = "BufRead",
    opts = {
      mappings = {
        add = "sa", -- Add surounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
  },
}
