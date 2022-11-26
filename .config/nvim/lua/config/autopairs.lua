local is_autopairs_present, pairs = pcall(require, "nvim-autopairs")

if is_autopairs_present then
	pairs.setup({})
end
