local _M = {
	terminal = os.getenv("TERMINAL") or "kitty",
	editor = os.getenv("EDITOR") or "vim",
	browser = "firefox",
	power_manager = "xfce4-power-manager-settings",
	screenlocker = "betterlockscreen -l blur --span",
	screenshot = "flameshot gui",
}

_M.editor_cmd = _M.terminal .. " -e " .. _M.editor
_M.manual_cmd = _M.terminal .. " - man awesome"

return _M
