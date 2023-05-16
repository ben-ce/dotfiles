------------------------
-- Formatter
------------------------
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "black", filetypes = { "python" } },
})

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

------------------------
-- Linter
------------------------
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "flake8", filetypes = { "python" } },
})

------------------------
-- DAP
------------------------
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
pcall(function()
	require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- Supported test frameworks are unittest, pytest and django. By default it
-- tries to detect the runner by probing for pytest.ini and manage.py, if
-- neither are present it defaults to unittest.
pcall(function()
	require("dap-python").test_runner = "pytest"
end)

------------------------
-- Key mappings
------------------------
local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	C = {
		name = "Python",
		v = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Pick Env" },
		s = { "<cmd>lua require('swenv.api').get_current_venv()<cr>", "Show Env" },
	},
}

which_key.register(mappings, opts)
