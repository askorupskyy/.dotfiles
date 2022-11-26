local is_lualine_present, lualine = pcall(require, "lualine")
local colors = require("colors")

-- TODO: Improve util and move somewhere else
local setup_on_buf_read = function(callback)
	vim.api.nvim_create_autocmd({ "BufRead" }, {
		pattern = { "*" },
		callback = callback,
	})
end

local theme = {
	normal = {
		a = { fg = colors.dark_black, bg = colors.blue },
		b = { fg = colors.light_gray, bg = colors.dark_black },
		c = { fg = colors.dark_black, bg = colors.dark_black },
		x = { fg = colors.dark_black, bg = colors.dark_black },
		y = { fg = colors.light_gray, bg = colors.dark_black },
		z = { fg = colors.light_gray, bg = colors.dark_black },
	},
	insert = {
		a = { fg = colors.dark_black, bg = colors.green },
		b = { fg = colors.light_gray, bg = colors.dark_black },
		c = { fg = colors.dark_black, bg = colors.dark_black },
		x = { fg = colors.dark_black, bg = colors.dark_black },
		y = { fg = colors.light_gray, bg = colors.dark_black },
		z = { fg = colors.light_gray, bg = colors.dark_black },
	},
	command = {
		a = { fg = colors.dark_black, bg = colors.red },
		b = { fg = colors.light_gray, bg = colors.dark_black },
		c = { fg = colors.dark_black, bg = colors.dark_black },
		x = { fg = colors.dark_black, bg = colors.dark_black },
		y = { fg = colors.light_gray, bg = colors.dark_black },
		z = { fg = colors.light_gray, bg = colors.dark_black },
	},
	visual = {
		a = { fg = colors.dark_black, bg = colors.cyan },
		b = { fg = colors.light_gray, bg = colors.dark_black },
		c = { fg = colors.dark_black, bg = colors.dark_black },
		x = { fg = colors.dark_black, bg = colors.dark_black },
		y = { fg = colors.light_gray, bg = colors.dark_black },
		z = { fg = colors.light_gray, bg = colors.dark_black },
	},
	replace = {
		a = { fg = colors.dark_black, bg = colors.red },
		b = { fg = colors.light_gray, bg = colors.dark_black },
		c = { fg = colors.dark_black, bg = colors.dark_black },
		x = { fg = colors.dark_black, bg = colors.dark_black },
		y = { fg = colors.light_gray, bg = colors.dark_black },
		z = { fg = colors.light_gray, bg = colors.dark_black },
	},
	inactive = {
		a = { fg = colors.light_gray, bg = colors.dark_black },
		b = { fg = colors.dark_black, bg = colors.dark_black },
		c = { fg = colors.dark_black, bg = colors.dark_black },
		x = { fg = colors.dark_black, bg = colors.dark_black },
		y = { fg = colors.dark_black, bg = colors.dark_black },
		z = { fg = colors.light_gray, bg = colors.dark_black },
	},
}

local setup_lualine = function()
	if is_lualine_present then
		lualine.setup({
			options = {
				icons_enabled = true,
				theme = theme,
				globalstatus = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {},
				always_divide_middle = true,
				padding = 1,
			},
			sections = {
				lualine_a = {
					-- {
					-- 	"mode",
					-- 	fmt = function()
					-- 		return " "
					-- 	end,
					-- },
				},
				lualine_b = {
					{
						"filename",
						path = 3,
						padding = 2,
						symbols = { modified = " [+]", readonly = " [-]", unnamed = "[No Name]" },
					},
				},
				lualine_c = {},
				lualine_x = {},
				lualine_y = { { "diagnostics", sources = { "nvim_diagnostic" }, padding = 2 } },
				lualine_z = { { "branch", icon = "" }, { "diff" }, { "location" }, { "progress" } },
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = { "quickfix" },
		})
	end
end

setup_on_buf_read(setup_lualine)
