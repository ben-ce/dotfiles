-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
Options = {
  plugins = {},
}
Options.plugins.colorscheme = "tokyonight-storm"
Options.plugins.animation_provider = "cinnamon"
Options.plugins.smoothcursor = true

vim.g.lazyvim_python_lsp = "basedpyright"
