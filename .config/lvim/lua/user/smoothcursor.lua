local status_ok, smoothcursor = pcall(require, "smoothcursor")
if not status_ok then
	return
end

smoothcursor.setup({
	speed = 100,
	disabled_filetypes = { "TelescopePrompt", "NvimTree", "harpoon" },
})
