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

local change_colorscheme = function(colorscheme)
	awful.spawn.with_shell(gears.filesystem.get_configuration_dir() .. "scripts/colorschemes/" .. colorscheme .. ".sh")
	awesome.restart()
end

-- img container button function
local function button(colorscheme_icon, colorscheme_name)
	local img_button = wbutton.image.normal({
		forced_width = dpi(70),
		forced_height = dpi(70),
		normal_bg = beautiful.colors.surface1,
		normal_shape = gears.shape.circle,
		on_normal_bg = beautiful.fg_normal,
		image = colorscheme_icon,
	})
	img_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
		change_colorscheme(colorscheme_name)
	end)))
	return img_button
end

-- populate img container buttons with available colorschemes
local colorscheme_selection = {}

for k, v in ipairs(require("theme.colorschemes")) do
	colorscheme_selection[k] = button(icons[v], v)
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
return function(s)
	s.colorscheme_popup = awful.popup({
		widget = {},
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
		screen = s,
		placement = function(w)
			awful.placement.centered(w)
		end,
	})

	-- add visibility toggle function to the popup
	local screen_backup = 1
	s.colorscheme_popup.toggle = function(screen)
		-- set screen to default, if none were found
		if not screen then
			screen = s
		end

		-- toggle visibility
		if s.colorscheme_popup.visible then
			-- check if screen is different or the same
			if screen_backup ~= screen.index then
				s.colorscheme_popup.visible = true
			else
				s.colorscheme_popup.visible = false
			end
		else
			s.colorscheme_popup.visible = true
		end

		-- set screen_backup to new screen
		screen_backup = screen.index
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
			s.colorscheme_popup.toggle(s)
		end,
	})

	-- construct the popup
	s.colorscheme_popup:setup({
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

	awesome.connect_signal("colorscheme_popup::toggle", function(scr)
		if scr == s then
			s.colorscheme_popup.toggle(scr)
		end
	end)
	return s.colorscheme_popup
end
