return require("packer").startup(function(use)
	-- Packer manages itself
	use("wbthomason/packer.nvim")
	-- Neovim utils required by other pkgs
	use("nvim-lua/plenary.nvim")
	-- Syntax highlights
	use("rktjmp/lush.nvim")
	use("pedropmedina/darkside")
	-- color highlights
	use("norcalli/nvim-colorizer.lua")
	-- File Icons
	use("kyazdani42/nvim-web-devicons")
	-- Treesitter (syntax tree)
	use({ "nvim-treesitter/nvim-treesitter" })
	use("nvim-treesitter/nvim-treesitter-refactor")
	use("nvim-treesitter/playground")
	-- Telescope (fuzzy finder)
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-fzy-native.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")
	-- Git gutter signs
	use("lewis6991/gitsigns.nvim")
	-- Statusline
	use("nvim-lualine/lualine.nvim")
	-- Lsp, DAP, linters, formatters intaller (makes it so much easier)
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")
	-- Cool icons in cmp dropdown
	use("onsails/lspkind-nvim")
	-- Completion dropdown
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("saadparwaiz1/cmp_luasnip")
	-- Autoclosing ([{''}])
	use("windwp/nvim-autopairs")
	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")
	-- Comment code with gc, gcc ...
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	-- Wrap, change, remove content with s, sr, sd
	use("tpope/vim-surround")
	-- Remove search highlight (:nohls) on cursor move
	use("haya14busa/is.vim")
    -- use("mustache/vim-mustache-handlebars")
    -- github copilot for AI code completion
    use("github/copilot.vim")
    -- discord presence plugin for my friends to see what im doing
    use("andweeb/presence.nvim")
    -- markdown preview plugin
    use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    })

    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
    -- todo comments for vim
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }
    -- matching pairs for html, css, json, yaml, and markdown
    use("tmhedberg/matchit")
    -- auto close html/jsx tags
    use("alvan/vim-closetag")
    -- change surrounding tags
    use("tpope/vim-surround")
    -- editorconfig support
    use("gpanders/editorconfig.nvim")
    -- buffer line
    use("akinsho/nvim-bufferline.lua")
end)
