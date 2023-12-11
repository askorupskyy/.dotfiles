-- https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("config").init()

-- https://github.com/folke/lazy.nvim#%EF%B8%8F-configuration
require("lazy").setup({
  spec = { { import = "pkgs" } },
  defaults = { lazy = false, version = nil },
  install = { colorscheme = { "catppuccin", "habamax" } },
  checker = { enabled = false },
  performance = {
    rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } },
  },
})
