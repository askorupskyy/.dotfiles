-- LSP Configuration & Plugins
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim

return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { "mason-org/mason.nvim", opts = {} }, -- NOTE: Must be loaded before dependants
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- Configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    { "folke/lazydev.nvim", ft = { "lua" }, opts = {} },
    -- Allows extra capabilities provided by blink.cmp
    "saghen/blink.cmp",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("ag__lsp_attach", { clear = true }),
      callback = function(args)
        -- In this case, we create a function that lets us more easily define mappings specific
        -- Sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
        end

        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

        --  This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        --  Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

        -- Find references for the word under your cursor.
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap.
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup("ag__lsp_highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = args.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = args.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("ag__lsp_detach", { clear = true }),
            callback = function(args2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "ag__lsp_highlight", buffer = args2.buf })
            end,
          })
        end

        -- The following autocommand is used to enable inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, "[T]oggle Inlay [H]ints")
        end

        -- Organize imports for *.ts files
        if client ~= nil and client.name == "ts_ls" then
          map("<leader>co", function()
            client:exec_cmd({
              title = "organize_imports",
              command = "_typescript.organizeImports",
              arguments = {
                vim.api.nvim_buf_get_name(args.buf),
              },
            }, { bufnr = args.buf })
          end, "[O]rganize [i]mports")
        end
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
    capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      -- Kotlin
      -- kotlin_language_server = {},

      -- Java [*.java]
      jdtls = {
        capabilities = {
          workspace = {
            configuration = true,
          },
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true,
              },
            },
          },
        },
      },
      -- SQL [*.sql]
      sqls = {
        on_attach = function(client, bufnr)
          require("sqls").on_attach(client, bufnr)
        end,
      },
      -- Lua [*.lua]
      lua_ls = {
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
      -- Javascript [*.js, *.ts, *.tsx, *.json, ...]
      ts_ls = {
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
      -- HTML [*.html, ...]
      html = {
        filetypes = { "html", "tsx", "jsx", "vue", "blade", "templ" },
        init_options = {
          provideFormatter = false,
        },
      },
      -- CSS [*.css]
      cssls = {
        settings = {
          css = { validate = false },
        },
      },
      -- Tailwindcss [*.css, *.tsx, ...]
      tailwindcss = {
        filetypes = {
          "astro",
          "templ",
          "hbs",
          "html",
          "mdx",
          "php",
          "css",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
        init_options = {
          userLanguages = {
            templ = "html",
          },
        },
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
      -- YAML
      yamlls = {
        settings = {
          yaml = { keyOrdering = false },
        },
      },
      -- Solidity
      solidity_ls_nomicfoundation = {
        settings = {
          cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
          filetypes = { "solidity" },
          single_file_support = true,
        },
      },
    }

    vim.keymap.set("n", "<leader>mm", "<cmd>Mason<cr>", { desc = "[M]ason [O]pen" })

    -- You can add other servers here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})

    require("mason-lspconfig").setup({
      ensure_installed = ensure_installed,
      automatic_enable = { exclude = { "jdtls" } },
    })

    for server, config in pairs(servers) do
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for tsserver)
      config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
      -- Run setup on all server except 'jdtls' since we're delegating such setup to 'nvim-jdtls' or
      -- which includes a set of functionalities out of the box 'jdtls' does not. This is required in
      -- to avoid ending up with two instances of 'jdtls'
      if server ~= "jdtls" then
        vim.lsp.config(server, config)
      end
    end
  end,
}
