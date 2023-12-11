local LazyUtil = require("lazy.core.util")

---@class util: LazyUtilCore
-- ---@field ui util.ui
---@field lsp util.lsp
---@field root util.root
---@field telescope util.telescope
---@field terminal util.terminal
---@field toggle util.toggle
---@field format util.format
---@field plugin util.plugin
---@field inject util.inject
---@field lualine util.lualine
local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    t[k] = require("util." .. k)
    return t[k]
  end,
})

-- Check if current OS is 'Windows'
function M.is_win()
  return vim.loop.os_uname().sysname:find("Windows") ~= nil
end

-- Check whether plugin exists or not
---@param plugin string
function M.has(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

-- Template to create VeryLazy autocmds
---@param fn fun()
function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      fn()
    end,
  })
end

-- Get defined lazy.core.config.plugins[plugin].opts for given plugin
---@param name string
function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

-- Check whether plugin has loaded or not
---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  local Config = require("lazy.core.config")
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

return M
