local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

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
