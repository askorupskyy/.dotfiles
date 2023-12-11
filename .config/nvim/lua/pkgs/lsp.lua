--[[
=============================================
=================== LSP =====================
=============================================

Probably the most important file in this entire config.
It hosts everything needed to get LSP up and running.
We're using neovim builtin support for LSP and delegating
the setup to mason-lspconfig.

Plugins:
  1. neovim/nvim-lspconfig 
  2. williamboman/mason.nvim

--]]

local Util = require("util")

local Keymaps = {}

---@type LazyKeysLspSpec[]|nil
Keymaps._keys = nil

---@diagnostic disable:undefined-doc-name,duplicate-doc-alias
---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string}
---@alias LazyKeysLsp LazyKeys|{has?:string}
---@diagnostic enable:undefined-doc-name,duplicate-doc-alias

---@return LazyKeysLspSpec[]
function Keymaps.get()
  if Keymaps._keys then
    return Keymaps._keys
  end
    -- stylua: ignore
    Keymaps._keys =  {
      { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
      { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
      { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
      { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
      {
        "<leader>cA",
        function()
          vim.lsp.buf.code_action({
            context = {
              only = {
                "source",
              },
              diagnostics = {},
            },
          })
        end,
        desc = "Source Action",
        has = "codeAction",
      }
    }

  if require("util").has("inc-rename.nvim") then
    Keymaps._keys[#Keymaps._keys + 1] = {
      "<leader>cr",
      function()
        local inc_rename = require("inc_rename")
        return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
      end,
      expr = true,
      desc = "Rename",
      has = "rename",
    }
  else
    Keymaps._keys[#Keymaps._keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
  end
  return Keymaps._keys
end

---@param method string
function Keymaps.has(buffer, method)
  method = method:find("/") and method or "textDocument/" .. method
  local clients = require("util").lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

---@diagnostic disable-next-line: undefined-doc-name
---@return (LazyKeys|{has?:string})[]
function Keymaps.resolve(buffer)
  local Keys = require("lazy.core.handler.keys")

  if not Keys.resolve then
    return {}
  end

  local spec = Keymaps.get()
  local opts = require("util").opts("nvim-lspconfig")
  local clients = require("util").lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

function Keymaps.on_attach(_, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = Keymaps.resolve(buffer)

  for _, keys in pairs(keymaps) do
    if not keys.has or Keymaps.has(buffer, keys.has) then
      local opts = Keys.opts(keys)
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, {
        has = nil,
        silent = opts.silent ~= false, ---@diagnostic disable-line:undefined-field
        buffer = buffer,
      })
    end
  end
end

-- Neovim builtin lsp configuration

------------------------------------------
-- neovim/nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig
--
-- Neovim builtin lsp configuration
------------------------------------------
return {
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    ---@class PluginLspOpts
    opts = {
      -- Options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      inlay_hints = {
        enabled = false,
      },
      -- Global capabilities
      capabilities = {},
      -- Options for vim.lsp.buf.format; `bufnr` and `filter` is handled by the formatter,
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP servers settings
      ---@diagnostic disable:missing-fields
      ---@type lspconfig.options
      servers = {
        ------------------------------------------
        -- lua
        ------------------------------------------
        lua_ls = {
          -- mason = false, Set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              format = { enable = false },
              runtime = { version = "LuaJIT" },
              -- Setting 'checkThirdParty' itn't working when set to boolean. Newer version accepts string instead.
              -- They do have backward compatability for boolean type, but it's having not effect.
              -- NOTE: https://github.com/LuaLS/lua-language-server/blob/5a763b0ceecc9a817c8ce534dc726f5f6f6e1ac9/script/library.lua#L612C57-L612C57
              workspace = { checkThirdParty = "Disable" }, ---@diagnostic disable-line: assign-type-mismatch
              completion = { callSnippet = "Replace" },
            },
          },
        },
        ------------------------------------------
        -- javascript, typescript, and friends...
        ------------------------------------------
        tsserver = {
          keys = {
            {
              "<leader>co",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.organizeImports.ts" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Organize Imports",
            },
            {
              "<leader>cR",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.removeUnused.ts" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Remove Unused Imports",
            },
          },
          settings = {
            typescript = {
              format = {
                enable = false,
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
            },
            javascript = {
              format = {
                enable = false,
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
            },
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
        ------------------------------------------
        -- HTML
        ------------------------------------------
        html = {
          filetypes = { "html", "tsx", "jsx", "vue" },
        },
        ------------------------------------------
        -- CSS
        ------------------------------------------
        cssls = {
          settings = {
            css = { validate = false },
          },
        },
        ------------------------------------------
        -- CSS
        ------------------------------------------
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  "tw`([^`]*)",
                  'tw="([^"]*)',
                  'tw={"([^"}]*)',
                  "tw\\.\\w+`([^`]*)",
                  "tw\\(.*?\\)`([^`]*)",
                },
              },
            },
          },
        },
        ------------------------------------------
        -- YAML
        ------------------------------------------
        yamlls = {
          settings = {
            yaml = { keyOrdering = false },
          },
        },
      },
      ---@diagnostic enable:missing-fields
      -- Add additional lsp server setup here. Return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- Example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      if Util.has("neoconf.nvim") then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      end

      -- Setup  autoformat included with lsp
      Util.format.register(Util.lsp.formatter())

      -- Setup keymaps per active client
      Util.lsp.on_attach(function(client, buffer)
        Keymaps.on_attach(client, buffer)
      end)

      -- Setup capabilities keymaps
      local register_capability = vim.lsp.handlers["client/registerCapability"]
      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        Keymaps.on_attach(client, buffer)
        return ret
      end

      -- Assign custom icons to diagnostic messages
      for name, icon in pairs(require("config").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      -- Enable hints for those servers supporting it
      local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
      if opts.inlay_hints.enabled and inlay_hint then
        Util.lsp.on_attach(function(client, buffer)
          if client.supports_method("textDocument/inlayHint") then
            inlay_hint(buffer, true)
          end
        end)
      end

      -- Assign corresponding diagnostic icon to message
      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
          or function(diagnostic)
            local icons = require("config").icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- Grab servers found under local 'opts'
      local servers = opts.servers

      -- Merge all capabilities together including 'cmp lsp'
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      -- Apply local setup options per server if defined under 'opts'
      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities or {}),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts or {}) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts or {}) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- Get all the servers that are available through 'mason-lspconfig'
      -- Keep in mind that mason exports two packages 'mason' and 'mason-lspconfig'.
      -- In order to properly set lsp we need to work/setup 'mason-lspconfig' not 'mason'
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      -- Keep track of servers we want to auto-install
      local ensure_installed = {} ---@type string[]

      -- Manually setup locally defined servers under 'opts' or push into 'ensure_installed' to let mason-lspconfig handle them
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      -- Delegate server setup to mason
      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end

      -- Automatically disable tsserver in favor of deno when within within a deno project
      if Util.lsp.get_config("denols") and Util.lsp.get_config("tsserver") then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        Util.lsp.disable("tsserver", is_deno)
        Util.lsp.disable("denols", function(root_dir)
          return not is_deno(root_dir)
        end)
      end
    end,
  },

  ---------------------------------------------
  -- williamboman/mason.nvim
  -- https://github.com/williamboman/mason.nvim
  --
  -- UI and tooling to interate with native lsp.
  ---------------------------------------------
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "prettier",
      },
    },
    -- Notice who we're extending Mason's default settings with 'ensure_installed'
    -- in order to setup the formatters as these ARE NOT part of 'mason-lspconfig'.
    -- This list is NOT part of Mason and will not be parsed in order to auto-install servers.
    -- In order to auto-install servers, you must use the 'mason-lspconfig'.setup({ ensure_installed: [...] }).
    -- In our case, we're handling this process by setting 'opts' under setup for neovim/nvim-lspconfig above ^
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)

      -- Get an instance of the registry where we can access helper fns
      local mr = require("mason-registry")

      -- Trigger FileType event to load newly installed LSP server after timeout
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      -- Go over 'ensure_installed' list and install if not present
      local function ensure_installed()
        for _, package_name in ipairs(opts.ensure_installed) do
          local package = mr.get_package(package_name)
          if not package:is_installed() then
            package:install()
          end
        end
      end

      -- Ensure we have everything up to day and install latest packages
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
