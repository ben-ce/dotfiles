#!/bin/bash

# Change awesome colorscheme
sed -i -E 's/(colorschemes)(\[)[[:digit:]]+(\])/\1\22\3/g' ~/.config/awesome/theme/init.lua

# Change kitty colorscheme
kitty +kitten themes --reload-in all "Tokyo Night Storm"

# Change neovim colorscheme
sed -i -E 's/(^lvim\.colorscheme = \")[[:alnum:]-]+(\")/\1tokyonight-storm\2/' ~/.config/lvim/lua/user/options.lua

# Change fzf colors in zsh
sed -i -E 's/(COLORSCHEME=")[[:alnum:]-]+(")/\1tokyonight-storm\2/' ~/.zshrc
