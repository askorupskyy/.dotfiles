-- TODO: Disable when on large files
-- https://www.reddit.com/r/neovim/comments/z85s1l/disable_lsp_for_very_large_files/
-- https://github.com/LunarVim/LunarVim/issues/3149

local is_treesitter_present, _ = pcall(require, "nvim-treesitter")

local ensured_installed_parsers = {
	"astro",
	"bash",
	"c",
	"css",
	"cmake",
	"comment",
	"dockerfile",
	"diff",
	"dot",
	"elixir",
	"fish",
	"go",
	"graphql",
	"html",
	"json",
	"javascript",
	"lua",
	"markdown",
	"php",
	"prisma",
	"python",
	"rust",
	"tsx",
	"typescript",
	"vim",
	"vue",
	"yaml",
}

if is_treesitter_present then
	require("nvim-treesitter.configs").setup({
		ensure_installed = ensured_installed_parsers,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
			disable = function(_, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		indent = { enable = false },
		context_commentstring = { enable = true, enable_autocmd = false },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gis",
				node_incremental = "gni",
				scope_incremental = "gsi",
				node_decremental = "gnd",
			},
		},
		refactor = {
			highlight_definitions = { enable = false }, -- Also slowing down on long files
			highlight_current_scope = { enable = false },
		},
		playground = {
			enable = false, -- slows down everything. Disable for now until we come up with a solution
			disable = {},
			updatetime = 25,
			persist_queries = false,
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
		},
	})
end
