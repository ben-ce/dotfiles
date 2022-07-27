local awful = require("awful")
local info_panel = require("ui.info-panel")

awful.screen.connect_for_each_screen(function (s)
  info_panel(s)
end)
