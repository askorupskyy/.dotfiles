return require("lazy").setup({
	-- Neovim utils required by other pkgs
	"nvim-lua/plenary.nvim",
	-- Syntax highlights
	"rktjmp/lush.nvim",
	"pedropmedina/darkside",
	-- color highlights
	"norcalli/nvim-colorizer.lua",
	-- File Icons
	"kyazdani42/nvim-web-devicons",
	-- Treesitter (syntax tree)
	{ "nvim-treesitter/nvim-treesitter" },
	"nvim-treesitter/nvim-treesitter-refactor",
	"nvim-treesitter/playground",
	-- Telescope (fuzzy finder)
	"nvim-telescope/telescope.nvim",
	"nvim-telescope/telescope-fzy-native.nvim",
	"nvim-telescope/telescope-file-browser.nvim",
	-- Git gutter signs
	"lewis6991/gitsigns.nvim",
	-- Statusline
	"nvim-lualine/lualine.nvim",
	-- Lsp, DAP, linters, formatters intaller (makes it so much easier)
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"jose-elias-alvarez/null-ls.nvim",
	"jayp0521/mason-null-ls.nvim",
	-- Cool icons in cmp dropdown
	"onsails/lspkind-nvim",
	-- Completion dropdown
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"saadparwaiz1/cmp_luasnip",
	-- Autoclosing ([{''}])
	"windwp/nvim-autopairs",
	-- Snippets
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
	-- Comment code with gc, gcc ...
	"numToStr/Comment.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",
	-- Wrap, change, remove content with s, sr, sd
	"tpope/vim-surround",
	-- Remove search highlight (:nohls) on cursor move
	"haya14busa/is.vim",
	-- "mustache/vim-mustache-handlebars")
	-- github copilot for AI code completion
	"github/copilot.vim",
	-- discord presence plugin for my friends to see what im doing
	"andweeb/presence.nvim",
	-- markdown preview plugin
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	-- todo comments for vim
	{
		"folke/todo-comments.nvim",
		dependencies = {"nvim-lua/plenary.nvim"},
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
	-- matching pairs for html, css, json, yaml, and markdown
	"tmhedberg/matchit",
	-- auto close html/jsx tags
	"alvan/vim-closetag",
	-- change surrounding tags
	"tpope/vim-surround",
	-- editorconfig support
	"gpanders/editorconfig.nvim",
	-- buffer line
	"akinsho/nvim-bufferline.lua",
})
