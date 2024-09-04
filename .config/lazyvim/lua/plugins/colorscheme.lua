return {
  {
    "folke/tokyonight.nvim",
    opts = { style = "storm" },
    enabled = Options.plugins.colorscheme == "tokyonight-storm",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    enabled = Options.plugins.colorscheme == "catppuccin-frappe"
      or Options.plugins.colorscheme == "catppuccin-macchiato",
  },
  -- --- Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    enabled = Options.plugins.colorscheme == "rose-pine",
    opts = {
      dark_variant = "moon",
    },
  },
}
