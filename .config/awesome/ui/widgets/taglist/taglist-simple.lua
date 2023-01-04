--  _____           _ _     _
-- |_   _|_ _  __ _| (_)___| |_
--   | |/ _` |/ _` | | / __| __|
--   | | (_| | (_| | | \__ \ |_
--   |_|\__,_|\__, |_|_|___/\__|
--            |___/

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local mod = require("bindings.modkeys")

local taglist_padding = 10

return function(s)
	return awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		style = {
			shape = gears.shape.rounded_rect,
		},
		widget_template = {
			{
				{
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					left = dpi(taglist_padding),
					right = dpi(taglist_padding),
					widget = wibox.container.margin,
				},
				id = "background_role",
				widget = wibox.container.background,
			},
			margins = dpi(2),
			widget = wibox.container.margin,
		},
		buttons = {
			awful.button({
				modifiers = {},
				button = 1,
				on_press = function(t)
					t:view_only()
				end,
			}),
			awful.button({
				modifiers = { mod.super },
				button = 1,
				on_press = function(t)
					if client.focus then
						client.focus:move_to_tag(t)
					end
				end,
			}),
			awful.button({
				modifiers = {},
				button = 3,
				on_press = awful.tag.viewtoggle,
			}),
			awful.button({
				modifiers = { mod.super },
				button = 3,
				on_press = function(t)
					if client.focus then
						client.focus:toggle_tag(t)
					end
				end,
			}),
			awful.button({
				modifiers = {},
				button = 4,
				on_press = function(t)
					awful.tag.viewprev(t.screen)
				end,
			}),
			awful.button({
				modifiers = {},
				button = 5,
				on_press = function(t)
					awful.tag.viewnext(t.screen)
				end,
			}),
		},
	})
end
