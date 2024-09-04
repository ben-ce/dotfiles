local opts = {
	filetypes = { "zsh" },
}

require("lvim.lsp.manager").setup("bashls", opts)
