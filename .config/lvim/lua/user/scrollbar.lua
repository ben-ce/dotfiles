local status_ok, scrollbar = pcall(require, "scrollbar")
if not status_ok then
	return
end

scrollbar.setup({
	excluded_filetypes = {
		"prompt",
		"TelescopePrompt",
		"noice",
		"notify",
	},
	marks = {
		GitAdd = {
			text = "│",
		},
		GitChange = {
			text = "│",
		},
	},
	handlers = {
		cursor = false,
		diagnostic = true,
		gitsigns = false, -- Requires gitsigns
		handle = true,
		search = false, -- Requires hlslens
	},
})
