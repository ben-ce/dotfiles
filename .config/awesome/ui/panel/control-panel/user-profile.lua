local awful = require("awful")
local focused = awful.screen.focused()
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")
local gears = require("gears")
local wbutton = require("ui.widgets.button")

--- User Profile Widget
--- ~~~~~~~~~~~~~~~~~~~

local function create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
	local box_container = wibox.container.background()
	box_container.bg = bg_color
	box_container.forced_height = height
	box_container.forced_width = width
	box_container.shape = helpers.ui.rrect(beautiful.border_radius)

	local boxed_widget = wibox.widget({
		--- Add margins
		{
			--- Add background color
			{
				--- The actual widget goes here
				widget_to_be_boxed,
				margins = dpi(15),
				widget = wibox.container.margin,
			},
			widget = box_container,
		},
		margins = dpi(10),
		color = "#FF000000",
		widget = wibox.container.margin,
	})

	return boxed_widget
end

local function widget()
	local icon = wibox.widget({
		{
			font = beautiful.font,
			markup = helpers.ui.colorize_text("", beautiful.widget_bg),
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		bg = beautiful.fg_normal,
		widget = wibox.container.background,
		shape = gears.shape.circle,
		forced_height = dpi(25),
		forced_width = dpi(25),
	})

	local image = wibox.widget({
		{
			{
				{
					image = beautiful.profile_icon,
					resize = true,
					clip_shape = gears.shape.circle,
					halign = "center",
					valign = "center",
					widget = wibox.widget.imagebox,
				},
				shape = gears.shape.circle,
				widget = wibox.container.background,
			},
			strategy = "exact",
			height = dpi(80),
			width = dpi(80),
			widget = wibox.container.constraint,
		},
		{
			nil,
			nil,
			{
				nil,
				nil,
				icon,
				layout = wibox.layout.align.horizontal,
				expand = "none",
			},
			layout = wibox.layout.align.vertical,
			expand = "none",
		},
		layout = wibox.layout.stack,
	})

	--- username
	local profile_name = wibox.widget({
		widget = wibox.widget.textbox,
		markup = "whoami",
		font = beautiful.font_name .. "Bold 10",
		valign = "center",
	})

	awful.spawn.easy_async_with_shell(
		[[
    sh -c '
    fullname="$(getent passwd `whoami` | cut -d ':' -f 5 | cut -d ',' -f 1 | tr -d "\n")"
    if [ -z "$fullname" ];
    then
      printf "$(whoami)@$(hostname)"
    else
      printf "$fullname"
    fi
    '
    ]],
		function(stdout)
			local stdout = stdout:gsub("%\n", "")
			profile_name:set_markup(stdout)
		end
	)

	--- uptime
	local uptime_time = wibox.widget({
		widget = wibox.widget.textbox,
		markup = "up 0 hours, 0 minutes",
		font = beautiful.font_name .. "Medium 10",
		valign = "center",
	})

	local update_uptime = function()
		awful.spawn.easy_async_with_shell("uptime -p", function(stdout)
			local uptime = stdout:gsub("%\n", "")
			uptime_time:set_markup(uptime)
		end)
	end

	gears.timer({
		timeout = 60,
		autostart = true,
		call_now = true,
		callback = function()
			update_uptime()
		end,
	})

	local profile = wibox.widget({
		{
			image,
			{
				nil,
				{
					{
						widget = wibox.container.scroll.horizontal,
						step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
						fps = 60,
						speed = 75,
						profile_name,
					},
					{
						widget = wibox.container.scroll.horizontal,
						step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
						fps = 60,
						speed = 75,
						uptime_time,
					},
					forced_width = dpi(200),
					layout = wibox.layout.fixed.vertical,
					spacing = dpi(2),
				},
				layout = wibox.layout.align.vertical,
				expand = "none",
			},
			layout = wibox.layout.fixed.horizontal,
			spacing = dpi(15),
		},
		{
			nil,
			nil,
			{
				wbutton.text.normal({
					forced_width = dpi(50),
					forced_height = dpi(50),
					font = beautiful.icon_font_name,
					text_normal_bg = beautiful.fg_normal,
					normal_bg = beautiful.colors.overlay1,
					text = "\u{f023}",
					size = 18,
					on_release = function()
						lock_screen_show()
						awesome.emit_signal("control_panel::toggle", focused)
					end,
				}),
				wbutton.text.normal({
					forced_width = dpi(50),
					forced_height = dpi(50),
					font = beautiful.icon_font_name,
					text_normal_bg = beautiful.colors.red,
					normal_bg = beautiful.colors.overlay1,
					text = "\u{f011}",
					size = 18,
					on_release = function()
						awesome.emit_signal("module::exit_screen:show")
						awesome.emit_signal("control_panel::toggle", focused)
					end,
				}),
				spacing = dpi(10),
				layout = wibox.layout.fixed.horizontal,
			},
			layout = wibox.layout.align.horizontal,
		},
		layout = wibox.layout.align.vertical,
	})

	return profile
end

return create_boxed_widget(widget(), dpi(350), dpi(160), beautiful.widget_bg)
