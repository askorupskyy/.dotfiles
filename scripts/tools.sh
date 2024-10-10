#!/bin/zsh

# install python 3.11 with pyenv
fish -c "pyenv install 3.11"
fish -c "pyenv global 3.11"

fish -c "pipx ensurepath"
fish -c "pipx install poetry"
fish -c "poetry completions"
