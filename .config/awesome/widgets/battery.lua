local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")


local battery_icon = wibox.widget({
  font = beautiful.font,
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
})

local battery_prog = wibox.widget({
	max_value = 100,
	min_value = 0,
	value = 20,
	forced_height = 3,
	forced_width = 75,
	color = beautiful.red,
	background_color = beautiful.primary,
	shape = gears.shape.rounded_bar,
	widget = wibox.widget.progressbar,
})

awesome.connect_signal("signal::battery", function(percentage, state)
	local value = percentage

	local bat_icon = "  "
	local bat_color = beautiful.green
  battery_icon.font = "MesloLGS Nerd Font 15"

	if value >= 0 and value <= 15 then
		bat_icon = "﮻ "
		bat_color = beautiful.red
	elseif value > 15 and value <= 20 then
		bat_icon = "  "
		bat_color = beautiful.red
  elseif value > 20 and value <= 30 then
		bat_icon = "  "
		bat_color = beautiful.orange
	elseif value > 30 and value <= 40 then
		bat_icon = "  "
		bat_color = beautiful.orange
	elseif value > 40 and value <= 50 then
		bat_icon = "  "
		bat_color = beautiful.yellow
	elseif value > 50 and value <= 60 then
		bat_icon = "  "
		bat_color = beautiful.yellow
	elseif value > 60 and value <= 70 then
		bat_icon = "  "
		bat_color = beautiful.yellow
	elseif value > 70 and value <= 80 then
		bat_icon = "  "
		bat_color = beautiful.white
	elseif value > 80 and value <= 90 then
		bat_icon = "  "
		bat_color = beautiful.white
	elseif value > 90 and value <= 100 then
		bat_icon = "  "
		bat_color = beautiful.white
	end

	-- if charging
	if state == 1 then
    battery_icon.font = beautiful.icon_font .. " " .. beautiful.icon_size
		bat_icon = " "
		bat_color = beautiful.blue
	end

	battery_prog.value = percentage

	battery_icon.markup = "<span foreground='" .. bat_color .. "'>" .. bat_icon .. "</span>"
end)

return battery_icon
