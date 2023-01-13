------------------------
-- LSP
------------------------
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })

local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("golangci_lint_ls", {
	on_init = require("lvim.lsp").common_on_init,
	capabilities = require("lvim.lsp").common_capabilities(),
})

lsp_manager.setup("gopls", {
	on_attach = function(client, bufnr)
		require("lvim.lsp").common_on_attach(client, bufnr)
		local _, _ = pcall(vim.lsp.codelens.refresh)
	end,
	on_init = require("lvim.lsp").common_on_init,
	capabilities = require("lvim.lsp").common_capabilities(),
	settings = {
		gopls = {
			usePlaceholders = true, -- enables placeholders for function parameters or struct fields in completion responses
			gofumpt = true,
			codelenses = {
				generate = false,
				gc_details = true,
				test = true,
				tidy = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			analyses = {
				fieldalignment = true, -- find structs that would use less memory if their fields were sorted
				nilness = true, -- check for redundant or impossible nil comparisons
				shadow = true, -- check for possible unintended shadowing of variables
				unusedparams = true, -- check for unused parameters of functions
				unusedwrite = true, -- checks for unused writes, an instances of writes to struct fields and arrays that are never read
			},
		},
	},
})

-- if it stops working with the custom setup we could apply some of these configs in lsp-settings/gopls.json:
-- {
--   "go.lintTool": "golangci-lint",
--   "go.formatTool": "goimports",
--   "gopls": {
--     "usePlaceholders": true,
--     "gofumpt": true,
--     "hints": {
--       "assignVariableTypes": true,
--       "compositeLiteralFields": true,
--       "constantValues": true,
--       "functionTypeParameters": true,
--       "parameterNames": true,
--       "rangeVariableTypes": true
--     },
--     "codelenses": {
--       "generate": false,
--       "gc_details": true,
--       "test": false,
--       "tidy": true
--     }
--   }
-- }
