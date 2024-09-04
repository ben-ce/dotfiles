local status_ok, cinnamon = pcall(require, "cinnamon")
if not status_ok then
	return
end

cinnamon.setup({
	keymaps = {
		extra = true,
		basic = true,
	},
	options = { mode = "window" },
})
