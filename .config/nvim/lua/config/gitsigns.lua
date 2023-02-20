local is_gitsigns_present, gitsigns = pcall(require, "gitsigns")

if is_gitsigns_present then
	gitsigns.setup({
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "▎" },
			topdelete = { text = "▎" },
			changedelete = { text = "▎" },
		},
		numhl = false,
		linehl = false,
		watch_gitdir = { interval = 1000, follow_files = true },
		current_line_blame = false,
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil,
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "<leader>]", function()
				if vim.wo.diff then
					return "<leader>]"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			map("n", "<leader>[", function()
				if vim.wo.diff then
					return "<leader>["
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			-- Actions
			map({ "n", "v" }, "<leader>hs", gs.stage_hunk)
			map({ "n", "v" }, "<leader>hr", gs.reset_hunk)
			map("n", "<leader>hS", gs.stage_buffer)
			map("n", "<leader>hu", gs.undo_stage_hunk)
			map("n", "<leader>hR", gs.reset_buffer)
			map("n", "<leader>hp", gs.preview_hunk)
			map("n", "<leader>tb", gs.toggle_current_line_blame)
			map("n", "<leader>hd", gs.diffthis)
			map("n", "<leader>td", gs.toggle_deleted)
			map("n", "<leader>hD", function()
				gs.diffthis("~")
			end)
			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end)

			-- Text object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
		end,
	})
end
