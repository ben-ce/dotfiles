local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")
local gears = require("gears")
local icons = require("icons")
local rubato = require("modules.rubato")

--- AWESOME Central panel
--- ~~~~~~~~~~~~~~~~~~~~~

return function(s)
	--- Header
	local function header()
		local dashboard_text = wibox.widget({
			markup = helpers.ui.colorize_text("Dashboard -", beautiful.accent),
			font = beautiful.font,
			valign = "center",
			widget = wibox.widget.textbox,
		})

		local function search_box()
			local search_icon = wibox.widget({
				-- font = "icomoon bold 12",
				font = beautiful.taglist_font,
				align = "center",
				valign = "center",
				widget = wibox.widget.textbox(),
			})

			local reset_search_icon = function()
				search_icon.markup = helpers.ui.colorize_text("\u{f002}", beautiful.accent)
			end
			reset_search_icon()

			local search_text = wibox.widget({
				-- markup = helpers.ui.colorize_text("Search", beautiful.color8),
				align = "center",
				valign = "center",
				font = beautiful.font,
				widget = wibox.widget.textbox(),
			})

			local search = wibox.widget({
				{
					{
						search_icon,
						{
							search_text,
							bottom = dpi(2),
							widget = wibox.container.margin,
						},
						layout = wibox.layout.fixed.horizontal,
					},
					left = dpi(15),
					widget = wibox.container.margin,
				},
				forced_height = dpi(35),
				forced_width = dpi(420),
				shape = gears.shape.rounded_bar,
				bg = beautiful.bg_focus,
				widget = wibox.container.background(),
			})

			local function generate_prompt_icon(icon, color)
				return "<span foreground='" .. color .. "'>" .. icon .. "</span> "
			end

			local function activate_prompt(action)
				search_icon.visible = false
				local prompt
				if action == "run" then
					prompt = generate_prompt_icon("\u{f120}", beautiful.accent)
				elseif action == "web_search" then
					prompt = generate_prompt_icon("\u{fa9e}", beautiful.accent)
				end
				helpers.misc.prompt(action, search_text, prompt, function()
					search_icon.visible = true
				end)
			end

			search:buttons(gears.table.join(
				awful.button({}, 1, function()
					activate_prompt("run")
				end),
				awful.button({}, 3, function()
					activate_prompt("web_search")
				end)
			))

			return search
		end

		local widget = wibox.widget({
			{
				dashboard_text,
				nil,
				search_box(),
				layout = wibox.layout.align.horizontal,
			},
			margins = dpi(10),
			widget = wibox.container.margin,
		})

		return widget
	end

	s.awesomewm = wibox.widget({
		{
			{
				image = gears.color.recolor_image(icons.awesome_logo, beautiful.accent),
				resize = true,
				halign = "center",
				valign = "center",
				widget = wibox.widget.imagebox,
			},
			strategy = "exact",
			height = dpi(40),
			widget = wibox.container.constraint,
		},
		margins = dpi(10),
		widget = wibox.container.margin,
	})

	--- Widgets
	-- s.stats = require("ui.panel.control-panel.stats")
	s.user_profile = require("ui.panel.control-panel.user-profile")
	s.quick_settings = require("ui.panel.control-panel.quick-settings")
	s.music = require("ui.panel.control-panel.music")
	s.charts = require("ui.panel.control-panel.charts")

	s.control_panel = awful.popup({
		type = "normal",
		screen = s,
		-- shape = function (cr, w, h)
		--   gears.shape.infobubble(cr, w, h, 10, 10, w/2 - 10/2 + 75)
		-- end,
		minimum_height = dpi(700),
		maximum_height = dpi(700),
		minimum_width = dpi(700),
		maximum_width = dpi(700),
		border_width = dpi(3),
		border_color = beautiful.bg_focus,
		bg = beautiful.bg_normal,
		ontop = true,
		visible = false,
		placement = function(w)
			awful.placement.top_right(w, {
				margins = {
					top = beautiful.wibar_height + dpi(beautiful.useless_gap * 2),
					bottom = dpi(5),
					left = dpi(5),
					right = dpi(beautiful.useless_gap * 2),
				},
			})
		end,
		widget = {
			{
				header(),
				margins = { top = dpi(10), bottom = dpi(10), right = dpi(20), left = dpi(20) },
				widget = wibox.container.margin,
			},
			{
				{
					{
						nil,
						{
							{
								s.user_profile,
								s.quick_settings,
								s.music,
								layout = wibox.layout.fixed.vertical,
							},
							{
								-- s.stats,
								s.charts,
								s.awesomewm,
								layout = wibox.layout.fixed.vertical,
							},
							layout = wibox.layout.align.horizontal,
						},
						layout = wibox.layout.align.vertical,
					},
					margins = dpi(10),
					widget = wibox.container.margin,
				},
				bg = beautiful.wibar_bg,
				shape = gears.shape.rounded_rect,
				widget = wibox.container.background,
			},
			layout = wibox.layout.align.vertical,
		},
	})

	-- -- sliding animation
	local slide_right = rubato.timed({
		pos = s.geometry.y - s.geometry.height,
		rate = 60,
		intro = 0.2,
		duration = 0.4,
		subscribed = function(pos)
			s.control_panel.y = pos
		end,
	})

	local slide_end = gears.timer({
		single_shot = true,
		timeout = 0.4 + 0.08,
		callback = function()
			s.control_panel.visible = false
		end,
	})
	-- -- Toggle function
	local screen_backup = 1

	s.control_panel.toggle = function(screen)
		-- set screen to default, if none were found
		if not screen then
			screen = s
		end

		-- popup x position is in the hands of the screen and placement function
		-- toggle visibility
		if s.control_panel.visible then
			-- check if screen is different or the same
			if screen_backup ~= screen.index then
				s.control_panel.visible = true
			else
				slide_end:again()
				slide_right.target = s.geometry.y - s.geometry.height
			end
		elseif not s.control_panel.visible then
			slide_right.target = s.geometry.y + (beautiful.wibar_height + beautiful.useless_gap * 2)
			s.control_panel.visible = true
		end

		-- set screen_backup to new screen
		screen_backup = screen.index
	end

	--- Toggle container visibility
	awesome.connect_signal("control_panel::toggle", function(scr)
		if scr == s then
			s.control_panel.toggle(scr)
			-- s.control_panel.visible = not s.control_panel.visible
		end
	end)

	helpers.click_to_hide.popup(s.control_panel, nil, true, s, "control_panel")
end
