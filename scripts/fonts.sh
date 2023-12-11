#!/bin/zsh

# this script is designed to download all the fonts i use on my system
wget=/usr/local/bin/wget
FONT_DIR=~/.dotfiles/downloads/fonts

fontList=(
  "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip"
)

echo "downloading fonts..."

for i in {1..$#fontList}; do
  eval wget "${fontList[i]}" -P $FONT_DIR -q
done

echo "DOWNLOADING: DONE!"

# unarchive fonts
echo "unarchiving fonts..."
for entry in "$FONT_DIR"/*.zip; do
  # here we unzip a font and remove the zip file
  unzip -qq -o "$entry" -d "$FONT_DIR"
  rm -f "$entry"
done

echo "UNZIPPING: DONE!"

echo "installing fonts:"
for entry in "$FONT_DIR"/*.ttf; do
  # install a font using a semantic link
  mv "$entry" ~/Library/Fonts/
done
