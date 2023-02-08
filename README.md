<!--toc:start-->

- [Required packages (by Arch Linux package name)](#required-packages-by-arch-linux-package-name)
- [Install](#install)
- [Required plugins](#required-plugins)
<!--toc:end-->

### Required packages (by Arch Linux package name)

- Package manager: `yay`
- Shell: `zsh`
- Shell extensions:
  - `zsh-syntax-highlighting`
  - `zsh-autosuggestions`
  - `zsh-theme-powerlevel10k-git`
  - `sheldon (plugin manager)`
- Display manager: `ligthdm`
- Window manager: `awesome-git`
- X compositor: `picom`
- Terminal emulator: `kitty`
- Application launcher: `rofi`
- Polkit agent: `polkit-gnome`
- Fuzzy finder: `fzf`
- `find` replacement: `fd`
- `grep` replacement: `ripgrep`
- `ls` replacement: `exa`
- `cat` replacement: `bat`
- `cd` replacement: `zoxide`
- Used fonts:
  - `ttf-jetbrains-mono-nerd`
  - `ttf-meslo-nerd`
  - `ttf-font-awesome`
  - `ttf-iosevka-nerd`
  - `ttf-material-icons-git`
- Icons: `papirus-icon-theme`
- Cursors: `mcmojave-cursors-git`
- Logon autostarter: `dex` (called by awesomewm module `config/xdg_autostart`)
- Python Venv manager: `python-virtualenvwrapper`
- Text editor: `neovim`

### Install

1. Clone the repo with submodules: `git clone --recurse-submodules URL TARGET_PATH`
2. Copy/symlink the files, eg.:

```
ln -s .zshrc ~/.zshrc
ln -s .p10k.zsh ~/.p10k.zsh
ln -s .xprofile ~/.xprofile
ln -s .Xresources ~/.Xresources
ln -s .config/autostart ~/.config/autostart
ln -s .config/awesome ~/.config/awesome
ln -s .config/bat ~/.config/bat
ln -s .config/kitty ~/.config/kitty
ln -s .config/lvim ~/.config/lvim
ln -s .config/picom ~/.config/picom
ln -s .config/rofi ~/.config/rofi
ln -s .config/sheldon ~/.config/sheldon
```

**TODO: look for a dotfile manager**

### Required plugins

- zsh: used plugins in `$XDG_CONFIG_HOME/sheldon/plugins.toml`
  - https://github.com/djui/alias-tips
  - https://github.com/hlissner/zsh-autopair
  - https://github.com/Aloxaf/fzf-tab
  - https://github.com/zsh-users/zsh-completions
- neovim: lunarvim IDE layer
  - install lunarvim: https://www.lunarvim.org/docs/installation
  - config for lunarvim should be in `$XDG_CONFIG_HOME/lvim/config.lua`
  - first time opening neovim it will pull, install and configure the core and user plugins
