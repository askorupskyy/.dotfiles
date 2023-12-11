--[[
=============================================
=============== COLORSCHEME =================
=============================================

catppuccin/nvim (https://github.com/catppuccin/nvim)

Catppuccin provides a pleasant color palette. It's also available
for pretty much all terminals. So yeah, it's very adoptable.
A thing I really like it's how flexible it is to tweak, check 
this issue (https://github.com/catppuccin/nvim/discussions/323) 
for some great examples showing entire transformations of the theme.

--]]

return {
  {
    "catppuccin/nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    name = "catppuccin",
    opts = {
      integrations = {
        cmp = true,
        gitsigns = true,
        illuminate = true,
        mason = true,
        mini = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
    },
    config = function(_, opts)
      local utils = require("catppuccin.utils.colors")
      opts.flavour = "mocha"
      opts.color_overrides = {
        mocha = {
          base = "#1d1f28",
          mantle = "#282a36",
          text = "#fdfdfd",
          rosewater = "#b6bdca",
          lavender = "#dfc5fe",
          red = "#ff4971",
          peach = "#d19a66",
          yellow = "#f2a272",
          green = "#86efac",
          teal = "#56b6c2",
          blue = "#8897f4",
          mauve = "#D19DFF",
          flamingo = "#D6409F",
        },
      }
      opts.custom_highlights = function(colors)
        return {
          TelescopeNormal = { bg = utils.darken(colors.base, 0.90) },
          TelescopeBorder = { bg = utils.darken(colors.base, 0.90) },
          TelescopePromptNormal = { bg = colors.mantle },
          TelescopePromptBorder = { bg = colors.mantle },
          TelescopePromptTitle = { bg = colors.blue, fg = colors.mantle },
          TelescopeResultsTitle = { bg = utils.darken(colors.base, 0.90), fg = utils.darken(colors.base, 0.90) },
        }
      end
      require("catppuccin").setup(opts)
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
