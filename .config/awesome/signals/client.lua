local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")

client.connect_signal("mouse::enter", function(c)
	c:activate({ context = "mouse_enter", raise = false })
end)

client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = {
		awful.button({
			modifiers = {},
			button = 1,
			on_press = function()
				c:activate({ context = "titlebar", action = "mouse_move" })
			end,
		}),
		awful.button({
			modifiers = {},
			button = 3,
			on_press = function()
				c:activate({ context = "titlebar", action = "mouse_resize" })
			end,
		}),
	}

	awful.titlebar(c).widget = {
		-- left
		{
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		-- middle
		{
			-- title
			{
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		-- right
		{
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	}
end)

-- Add awesome native rounded corners to clients (no anti-aliasing). For a better look use the picom compositor.
-- client.connect_signal("manage", function(c)
-- 	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
-- 		awful.placement.no_offscreen(c)
-- 	end
-- 	c.shape = function(cr, w, h)
-- 		gears.shape.rounded_rect(cr, w, h, beautiful.corner_radius)
-- 	end
-- end)
