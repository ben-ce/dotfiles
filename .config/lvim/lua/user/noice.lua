local status_ok, noice = pcall(require, "noice")
if not status_ok then
	return
end

noice.setup({
	-- cmdline = {
	-- 	format = {
	-- 		cmdline = {
	-- 			view = "cmdline",
	-- 		},
	-- 	},
	-- },
	presets = {
		bottom_search = false, -- use a classic bottom cmdline for search
		command_palette = false, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
	lsp = {
		progress = {
			enabled = false, -- disable lsp progress bc we use fidget.nvim plugin for this
		},
		hover = { enabled = true },
		signature = { enabled = false, auto_open = { enabled = false } },
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	messages = {
		enabled = false,
	},
})
