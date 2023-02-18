#!/bin/zsh

# this script is desgined to install the language server protocols that cannot be installed with node

# install gopls
fish -c "go get golang.org/x/tools/gopls@latest"
