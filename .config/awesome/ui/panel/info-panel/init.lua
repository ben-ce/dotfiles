local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")
local gears = require("gears")
local rubato = require("modules.rubato")

--- Information Panel
--- ~~~~~~~~~~~~~~~~~

return function(s)
	--- Date
	local time_format = "<span font='" .. beautiful.font_name .. "Light 36'> %H:%M </span> "
	local date_formate = "<span font='" .. beautiful.font_name .. "Bold 12'> %A %B %d </span>"
	local time = wibox.container.place(wibox.widget.textclock(time_format, 60))
	local date = wibox.container.place(wibox.widget.textclock(date_formate, 60))

	local date_time = wibox.widget({
		{
			time,
			date,
			layout = wibox.layout.fixed.vertical,
		},
		margins = dpi(20),
		widget = wibox.container.margin,
	})

	--- Calendar
	s.calendar = require("ui.panel.info-panel.calendar")()

	--- Weather
	s.weather = require("ui.panel.info-panel.weather")

	s.info_panel = awful.popup({
		type = "normal",
		screen = s,
		-- shape = function (cr, w, h)
		--   gears.shape.infobubble(cr, w, h, 10)
		-- end,
		minimum_width = dpi(350),
		maximum_width = dpi(350),
		border_width = dpi(3),
		border_color = beautiful.bg_focus,
		bg = beautiful.bg_normal,
		ontop = true,
		visible = false,
		placement = function(w)
			awful.placement.top(w, {
				margins = {
					top = beautiful.wibar_height + dpi(beautiful.useless_gap * 2),
					left = dpi(5),
					right = dpi(5),
				},
			})
		end,
		widget = {
			{
				date_time,
				{
					{
						s.calendar,
						margins = { top = dpi(8), left = dpi(16), bottom = dpi(16), right = dpi(16) },
						widget = wibox.container.margin,
					},
					bg = beautiful.widget_bg,
					shape = helpers.ui.rrect(beautiful.border_radius),
					widget = wibox.container.background,
				},
				{
					top = dpi(20),
					widget = wibox.container.margin,
				},
				{
					{
						s.weather,
						margins = dpi(16),
						widget = wibox.container.margin,
					},
					bg = beautiful.widget_bg,
					shape = helpers.ui.rrect(beautiful.border_radius),
					widget = wibox.container.background,
				},
				{
					top = dpi(20),
					widget = wibox.container.margin,
				},
				layout = wibox.layout.fixed.vertical,
			},
			margins = { top = dpi(10), bottom = dpi(10), left = dpi(25), right = dpi(25) },
			shape = helpers.ui.rrect(beautiful.border_radius),
			widget = wibox.container.margin,
		},
	})

	-- -- sliding animation
	local slide_right = rubato.timed({
		pos = s.geometry.y - s.geometry.height,
		rate = 60,
		intro = 0.2,
		duration = 0.4,
		subscribed = function(pos)
			s.info_panel.y = pos
		end,
	})

	local slide_end = gears.timer({
		single_shot = true,
		timeout = 0.4 + 0.08,
		callback = function()
			s.info_panel.visible = false
		end,
	})
	-- -- Toggle function
	local screen_backup = 1

	s.info_panel.toggle = function(screen)
		-- set screen to default, if none were found
		if not screen then
			screen = s
		end

		-- popup x position is in the hands of the screen and placement function
		-- toggle visibility
		if s.info_panel.visible then
			-- check if screen is different or the same
			if screen_backup ~= screen.index then
				s.info_panel.visible = true
			else
				slide_end:again()
				slide_right.target = s.geometry.y - s.geometry.height
			end
		elseif not s.info_panel.visible then
			slide_right.target = s.geometry.y + (beautiful.wibar_height + beautiful.useless_gap * 2)
			s.info_panel.visible = true
		end

		-- set screen_backup to new screen
		screen_backup = screen.index
	end

	--- Toggle container visibility
	awesome.connect_signal("info_panel::toggle", function(scr)
		if scr == s then
			s.info_panel.toggle(scr)
		end
	end)

	helpers.click_to_hide.popup(s.info_panel, nil, true, s, "info_panel")
end
