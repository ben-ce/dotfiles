-- LSP settings
-- Rust, Python, Go is configured by Lunarvim in `$RUNTIME_DIR/ftplugin/$LANGUAGE.lua` to enable lazy loading: https://www.lunarvim.org/docs/master/configuration/language-features/linting-and-formatting#lazy-loading-the-linterformattercode_actions-setup

-- Linters / Formatters
-- <https://www.lunarvim.org/docs/languages#lintingformatting>
-- Set a linter/formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "prettier", filetypes = { "markdown", "yaml" } },
	{
		command = "prettier",
		args = { "--print-width", "100" },
		filetypes = { "typescript", "typescriptreact" },
	},
	{ command = "rubocop", filetypes = { "ruby" } },

	-- we can use separate standalone rustfmt to format on save with null-ls but if we use rust-analyzer that has builtin rustfmt formatter
	-- { command = "rustfmt", filetypes = { "rust" } },
})
-- --- Linter
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "yamllint", filetypes = { "yaml" } },
})

-- --- EXAMPLE CONFIGS
-- --- LSP

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- --- Formatters
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- --- Linter
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }
