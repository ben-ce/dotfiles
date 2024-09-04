return {
  {
    "declancm/cinnamon.nvim",
    enabled = Options.plugins.animation_provider == "cinnamon",
    event = "WinScrolled",
    opts = {
      keymaps = {
        extra = true,
        basic = true,
      },
      options = { mode = "window" },
    },
  },
}
