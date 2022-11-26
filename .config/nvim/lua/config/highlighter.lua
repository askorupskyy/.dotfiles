local is_highlighter_present, colorizer = pcall(require, "colorizer")

if is_highlighter_present then
	colorizer.setup()
end
