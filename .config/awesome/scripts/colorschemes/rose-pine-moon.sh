#!/bin/bash

# Change awesome colorscheme
sed -i -E 's/(colorschemes)(\[)[[:digit:]]+(\])/\1\25\3/g' ~/.config/awesome/theme/init.lua

# Change kitty colorscheme
kitty +kitten themes --reload-in all "Rosé Pine Moon"

# Change neovim colorscheme
sed -i -E 's/(^lvim\.colorscheme = \")[[:alnum:]-]+(\")/\1rose-pine\2/' ~/.config/lvim/lua/user/options.lua
