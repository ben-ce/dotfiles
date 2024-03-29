---@diagnostic disable: undefined-global
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local dpi = beautiful.xresources.apply_dpi

-- signals
require("signals.cpu")
require("signals.ram")
require("signals.disk")
require("signals.temperature")

-- charts
local function mkchart(header, icon)
	return wibox.widget({
		{
			{
				{
					{
						{
							markup = header,
							widget = wibox.widget.textbox,
						},
						fg = beautiful.fg_normal,
						widget = wibox.container.background,
					},
					left = beautiful.useless_gap,
					widget = wibox.container.margin,
				},
				{
					{
						{
							{
								{
									{
										markup = icon,
										font = beautiful.alt_font_name .. "34",
										widget = wibox.widget.textbox,
									},
									direction = "west",
									widget = wibox.container.rotate,
								},
								halign = "center",
								valign = "center",
								layout = wibox.container.place,
							},
							id = "chart",
							value = 0,
							max_value = 1,
							min_value = 0,
							forced_height = 120,
							forced_width = 120,
							thickness = dpi(10),
							rounded_edge = true,
							widget = wibox.container.arcchart,
							bg = beautiful.bg_normal,
							colors = beautiful.colors.blue,
						},
						direction = "east",
						widget = wibox.container.rotate,
					},
					halign = "center",
					layout = wibox.container.place,
				},
				nil,
				layout = wibox.layout.align.vertical,
			},
			margins = beautiful.useless_gap,
			widget = wibox.container.margin,
		},
		shape = helpers.ui.rrect(beautiful.border_radius),
		bg = beautiful.widget_bg,
		widget = wibox.container.background,
		set_chart_value = function(self, value)
			self:get_children_by_id("chart")[1].value = value
		end,
	})
end

-- initialize charts
local cpu = mkchart("CPU", "\u{f4bc}")
local mem = mkchart("RAM", "\u{e266}")
local disk = mkchart("Disk", "\u{f02ca}")
local temp = mkchart("Temp", "\u{f03c8}")

-- give charts values
awesome.connect_signal("cpu::percent", function(percent)
	-- cpu chart could break sometimes, idk why, but throws some errors
	-- sometimes, so, i'll handle errors lol.
	local function get_percent()
		return percent / 100
	end

	if pcall(get_percent) then
		cpu.chart_value = get_percent()
	end
end)

awesome.connect_signal("ram::used", function(used)
	mem.chart_value = used / 100
end)

awesome.connect_signal("disk::usage", function(used)
	disk.chart_value = used / 100
end)

awesome.connect_signal("temperature::value", function(temperature)
	-- temp chart could break sometimes, idk why, but throws some errors
	-- sometimes, so, i'll handle errors lol.
	local function get_value()
		return temperature / 100
	end

	if pcall(get_value) then
		temp.chart_value = get_value()
	end
end)

-- main widget
return wibox.widget({
	{
		{
			cpu,
			mem,
			spacing = beautiful.useless_gap,
			layout = wibox.layout.flex.horizontal,
		},
		{
			temp,
			disk,
			spacing = beautiful.useless_gap,
			layout = wibox.layout.flex.horizontal,
		},
		spacing = beautiful.useless_gap * 2,
		layout = wibox.layout.flex.vertical,
	},
	top = beautiful.useless_gap,
	bottom = beautiful.useless_gap,
	widget = wibox.container.margin,
})
