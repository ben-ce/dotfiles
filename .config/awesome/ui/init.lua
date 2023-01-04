local awful = require("awful")
local info_panel = require("ui.panel.info-panel")
local control_panel = require("ui.panel.control-panel")
local notification_panel = require("ui.panel.notification-panel")

require("ui.notifications")

awful.screen.connect_for_each_screen(function(s)
	control_panel(s)
	info_panel(s)
	notification_panel(s)
end)
