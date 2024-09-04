-- escape sequence for jj and jk
return {
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
    event = "InsertEnter",
  },
}
