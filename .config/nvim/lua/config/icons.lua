local is_web_icons_present, web_icons = pcall(require, "nvim-web-devicons")
local colors = require("colors")

if is_web_icons_present then
	web_icons.setup({
		override = {
			html = { icon = "", color = colors.red, name = "html" },
			css = { icon = "", color = colors.dark_yellow, name = "css" },
			js = { icon = "", color = colors.yellow, name = "js" },
			ts = { icon = "", color = colors.blue, name = "ts" },
			jsx = { icon = "", color = colors.blue, name = "jsx" },
			tsx = { icon = "", color = colors.blue, name = "jsx" },
			json = { icon = "", color = colors.yellow, name = "json" },
			kt = { icon = "󱈙", color = colors.purple, name = "kt" },
			png = { icon = "", color = colors.light_gray, name = "png" },
			jpg = { icon = "", name = "jpg" },
			jpeg = { icon = "", color = colors.light_gray, name = "jpeg" },
			mp3 = { icon = "", color = colors.light_gray, name = "mp3" },
			mp4 = { icon = "", color = colors.light_gray, name = "mp4" },
			out = { icon = "", color = colors.light_gray, name = "out" },
			Dockerfile = { icon = "", color = colors.gray, name = "Dockerfile" },
			dockerignore = { icon = "", color = colors.light_gray, name = "dockerignore" },
			rb = { icon = "", color = colors.dark_red, name = "rb" },
			vue = { icon = "﵂", color = colors.green, name = "vue" },
			py = { icon = "", color = colors.yellow, name = "py" },
			toml = { icon = "", color = colors.gray, name = "toml" },
			lock = { icon = "", color = colors.gray, name = "lock" },
			zip = { icon = "", color = colors.gray, name = "zip" },
			xz = { icon = "", color = colors.gray, name = "xz" },
			deb = { icon = "", color = colors.gray, name = "deb" },
			rpm = { icon = " ", color = colors.gray, name = "rpm" },
			lua = { icon = "", color = colors.blue, name = "lua" },
			vim = { icon = "", color = colors.green, name = "vim" },
			vimrc = { icon = "", color = colors.green, name = "vimrc" },
			LICENSE = { icon = "", color = colors.yellow, name = "LICENSE" },
		},
	})
end
