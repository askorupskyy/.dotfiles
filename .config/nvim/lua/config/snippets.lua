local is_luasnip_present, luasnip = pcall(require, "luasnip")

if is_luasnip_present then
	luasnip.config.set_config({
		history = true,
		updateevents = "TextChanged,TextChangedI",
	})

	require("luasnip/loaders/from_vscode").load()
end
