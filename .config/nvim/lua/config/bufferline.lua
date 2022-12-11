local colors = require("colors")

require("bufferline").setup({
  options = {
    modified_icon = "",
    max_prefix_length = 15,
    tab_size = 18,
    separator_style = {"", ""},
    sort_by = "directory",
    mode = "tabs",
    truncate_names = true,
  },

  highlights = {
    -- make the background of buffeline the same as the background of the editor
    fill = {
      bg = colors.dark_black,
    },
    buffer = {
      bg = colors.dark_black,
    }
  },
})
