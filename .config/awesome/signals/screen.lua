local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")

local vars = require("config.vars")
local widgets = require("ui.widgets")
local popups = require("ui.popups")

-- Simple single wallpaper
-- screen.connect_signal('request::wallpaper', function(s)
--    awful.wallpaper{
--       screen = s,
--       widget = {
--          {
--             image     = beautiful.wallpaper,
--             resize    = true,
--             widget    = wibox.widget.imagebox,
--          },
--          valign = 'center',
--          halign = 'center',
--          tiled = false,
--          widget = wibox.container.tile,
--       }

--    }
-- end)

-- Slideshow wallpaper
screen.connect_signal("request::wallpaper", function(s)
	awful.wallpaper({
		screen = s,
		widget = {
			{
				image = gears.filesystem.get_random_file_from_dir(
					beautiful.wallpaper_dir,
					{ ".jpg", ".png", ".svg" },
					true
				),
				resize = true,
				horizontal_fit_policy = "fit",
				vertical_fit_policy = "fit",
				widget = wibox.widget.imagebox,
			},
			valign = "center",
			halign = "center",
			tiled = false,
			widget = wibox.container.tile,
		},
	})
end)

screen.connect_signal("request::desktop_decoration", function(s)
	awful.tag(vars.tags, s, awful.layout.layouts[1])
	s.launcher = widgets.launcher
	s.taglist = widgets.taglist(s)
	s.tasklist = widgets.tasklist(s)
	s.clock = widgets.clock(s)
	s.kblayout = widgets.create_keyboardlayout()
	s.systray = widgets.systray(s)
	s.controlcenter_button = widgets.controlcenter_button(s)
	s.notification_button = widgets.notification_button(s)
	s.volume = widgets.volume
	s.brightness = widgets.brightness
	s.battery = widgets.battery()
	s.layoutbox = widgets.layoutbox(s)
	s.osd = popups.osd_popup(s)
	s.colorscheme_popup = popups.colorscheme_popup(s)
	s.wibox = widgets.create_wibox(s)
end)
