local is_treesitter_present, _ = pcall(require, "nvim-treesitter")

if is_treesitter_present then
	require("nvim-treesitter.configs").setup({
		ensure_installed = {"bash", "c", "cpp", "css", "dockerfile", "go", "html", "javascript", "json", "lua", "python", "regex", "rust", "toml", "tsx", "typescript", "yaml", "markdown_inline"},
		highlight = { enable = true },
		indent = { enable = false },
		context_commentstring = { enable = true },
		rainbow = { enable = false },
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
			highlight_definitions = { enable = true },
			highlight_current_scope = { enable = false },
		},
		playground = {
			enable = true,
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
