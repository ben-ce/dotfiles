-- ~~~~~~~~~~~~
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local icons = require("icons")
local wbutton = require("ui.widgets.button")
local twidget = require("ui.widgets.text")

local change_dark_theme = function()
	awful.spawn.with_shell(gears.filesystem.get_configuration_dir() .. "scripts/themes/dark")
	awesome.restart()
end

-- return function(s)
-- img container button function
local function button(icon)
	return wbutton.image.normal({
		forced_width = dpi(60),
		forced_height = dpi(60),
		normal_bg = beautiful.colors.surface1,
		normal_shape = gears.shape.circle,
		on_normal_bg = beautiful.fg_normal,
		image = icon,
	})
end

-- populate img container buttons with available colorschemes
local colorscheme_selection = {}

for k, v in ipairs(require("theme.colorschemes")) do
	colorscheme_selection[k] = button(icons[v])
end

-- popup title widget
local title = twidget({
	size = 12,
	text = "Choose a colorscheme:",
})

-- define widget to contain buttons
local layout = wibox.widget({
	layout = wibox.layout.flex.horizontal,
	spacing = dpi(10),
})

-- place buttons in their 'layout' widget
for _, img_button in ipairs(colorscheme_selection) do
	layout:add(img_button)
end

-- create the popup
local colorscheme_popup = wibox({
	height = dpi(140),
	width = dpi(340),
	shape = gears.shape.rounded_rect,
	bg = beautiful.bg,
	border_width = dpi(3),
	border_color = beautiful.fg_normal,
	halign = "center",
	valign = "center",
	visible = false,
	ontop = true,
})

-- place popup in the middle of the screen
awful.placement.centered(colorscheme_popup, {})

-- add visibility toggle function to the popup
colorscheme_popup.toggle = function()
	if colorscheme_popup.visible == false then
		colorscheme_popup.visible = not colorscheme_popup.visible
	else
		colorscheme_popup.visible = false
	end
end

-- define dismiss button for the popup
local dismiss = wbutton.text.state({
	font = beautiful.alt_font_name,
	paddings = dpi(8),
	size = 14,
	text = "",
	normal_bg = beautiful.colors.surface1,
	normal_shape = gears.shape.circle,
	on_normal_bg = beautiful.fg_normal,
	text_normal_bg = beautiful.colors.red,
	text_on_normal_bg = beautiful.colors.surface1,
	animate_size = false,
	on_release = function()
		colorscheme_popup.toggle()
	end,
})

-- construct the popup
colorscheme_popup:setup({
	{
		layout = wibox.layout.fixed.vertical,
		spacing = dpi(10),
		{
			layout = wibox.layout.align.horizontal,
			title,
			nil,
			dismiss,
		},
		{
			layout,
			layout = wibox.layout.fixed.horizontal,
		},
	},
	widget = wibox.container.margin,
	margins = { left = dpi(10), right = dpi(10), bottom = dpi(10) },
})

return colorscheme_popup
