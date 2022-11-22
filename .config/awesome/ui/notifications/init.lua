local awful = require('awful')
local wibox = require("wibox")
local gears = require('gears')
local naughty = require("naughty")
local ruled = require("ruled")
local menubar = require('menubar')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local wbutton = require("ui.widgets.button")
local animation = require("modules.animation")

require(... .. ".playerctl")
require(... .. ".battery")

local function play_sound(n)
    if n.category == "device.added" or n.category == "network.connected" then
        awful.spawn("canberra-gtk-play -i service-login", false)
    elseif n.category == "device.removed" or n.category == "network.disconnected" then
        awful.spawn("canberra-gtk-play -i service-logout", false)
    elseif n.category == "device.error" or n.category == "im.error" or n.category == "network.error" or n.category == "transfer.error" then
        awful.spawn("canberra-gtk-play -i dialog-warning", false)
    elseif n.category == "email.arrived" then
        awful.spawn("canberra-gtk-play -i message", false)
    else
        awful.spawn("canberra-gtk-play -i bell", false)
    end
end

-- ruled notification
ruled.notification.connect_signal("request::rules", function()
  ruled.notification.append_rule {
    rule = {},
    properties = {
      screen = awful.screen.preferred,
      implicit_timeout = 10,
      resident = true,
    }
  }
  ruled.notification.append_rule {
    rule       = { urgency = "critical" },
    properties = { bg = beautiful.red, implicit_timeout = 0 }
  }
end)

-- connect to each display
-- ~~~~~~~~~~~~~~~~~~~~~~~
naughty.connect_signal("request::display", function(n)
  -- colors setup for urgency
  local colors = {
    foreground = beautiful.fg_normal,
    background = beautiful.bg_normal
  }
  if n.urgency == "critical" then
    colors.foreground = beautiful.bg_normal
    colors.background = beautiful.red
  end
  --- random accent color
	local accent_colors = beautiful.random_accent_color()

	--- table of icons
	local app_icons = {
		["firefox"] = { icon = "" },
		["skype"] = { icon = "" },
		["music"] = { icon = "" },
		["screenshot tool"] = { icon = "" },
	}

	local app_icon = nil
	local tolow = string.lower

	if app_icons[tolow(n.app_name)] then
		app_icon = app_icons[tolow(n.app_name)].icon
	else
		app_icon = ""
	end

	local app_icon_n = wibox.widget({
		{
			font = beautiful.icon_font_name .. "Round 10",
			markup = "<span foreground='" .. beautiful.bg_normal .. "'>" .. app_icon .. "</span>",
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		bg = beautiful.fg_normal,
		widget = wibox.container.background,
		shape = gears.shape.circle,
		forced_height = dpi(20),
		forced_width = dpi(20),
	})
  -- action widget
  local action_widget = {
    {
      {
        id = "text_role",
        align = "center",
        valign = "center",
        font = beautiful.font_name .. "10",
        widget = wibox.widget.textbox
      },
      left = dpi(6),
      right = dpi(6),
      widget = wibox.container.margin
    },
    bg = beautiful.bg_focus,
    forced_height = dpi(30),
    shape = gears.shape.rounded_rect,
    widget = wibox.container.background
  }

  -- actions
  local actions = wibox.widget {
    notification = n,
    base_layout = wibox.widget {
      spacing = dpi(8),
      layout = wibox.layout.flex.horizontal
    },
    widget_template = action_widget,
    style = {underline_normal = false, underline_selected = true},
    widget = naughty.list.actions
  }

  local dismiss = wbutton.text.state {
    font = beautiful.alt_font_name,
    paddings = dpi(8),
    size = 14,
    text = "",
    normal_bg = beautiful.black,
    normal_shape = gears.shape.circle,
    on_normal_bg = beautiful.accent,
    text_normal_bg = beautiful.red,
    text_on_normal_bg = beautiful.black,
    animate_size = false,
    on_release = function()
      n:destroy(naughty.notification_closed_reason.dismissed_by_user)
    end
  }

  -- image
  local image_n = wibox.widget {
    {
      {
        {
          image = n.icon,
          resize = true,
          clip_shape = gears.shape.circle,
          halign = "center",
          valign = "center",
          widget = wibox.widget.imagebox,
        },
        border_width = dpi(2),
        border_color = beautiful.accent,
        shape = gears.shape.circle,
        widget = wibox.container.background,
      },
      strategy = "exact",
      height = dpi(52),
      width = dpi(52),
      widget = wibox.container.constraint,
    },
    {
      nil,
      nil,
      {
        nil,
        nil,
        app_icon_n,
        layout = wibox.layout.align.horizontal,
        expand = "none",
      },
      layout = wibox.layout.align.vertical,
      expand = "none",
    },
    layout = wibox.layout.stack,
  }

  -- title
  local title_n = wibox.widget{
    {
      markup      = n.title,
      font        = beautiful.font_name .. "Bold 11",
      align       = "left",
      valign      = "center",
      widget      = wibox.widget.textbox
    },
    forced_width    = dpi(200),
    widget          = wibox.container.scroll.horizontal,
    step_function   = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
    speed           = 50
  }

  local message_n = wibox.widget{
    {
      markup      = helpers.ui.colorize_text(n.message, colors.foreground .. "BF"),
      font        = beautiful.font_name .. " 11",
      align       = "left",
      valign      = "center",
      wrap        = "char",
      widget      = wibox.widget.textbox
    },
    forced_width    = dpi(200),
    layout = wibox.layout.fixed.horizontal
  }

  -- app name
  local app_name_n = wibox.widget{
    markup      = helpers.ui.colorize_text(n.app_name, colors.foreground .. "BF"),
    font        = beautiful.font_name .. " 10",
    align       = "left",
    valign      = "center",
    widget      = wibox.widget.textbox
  }

  local time_n = wibox.widget{
      markup      = helpers.ui.colorize_text(os.date("%H:%M"), colors.foreground .. "BF"),
      font        = beautiful.font_name .. " 10",
      align       = "right",
      valign      = "center",
      widget      = wibox.widget.textbox
  }

  -- extra info
  local notif_info = wibox.widget{
    app_name_n,
    {
      widget = wibox.widget.separator,
      shape = gears.shape.circle,
      forced_height = dpi(4),
      forced_width = dpi(4),
      color = colors.foreground .."BF"
    },
    time_n,
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(7)
  }

  -- init
  local widget = naughty.layout.box {
    notification = n,
    type    = "notification",
    shape   = gears.shape.rounded_rect,
    border_width = dpi(2),
    border_color = beautiful.bg_focus,
    widget_template = {
      {
        layout = wibox.layout.fixed.vertical,
        {
          {
            layout = wibox.layout.fixed.vertical,
            {
              layout = wibox.layout.align.horizontal,
              notif_info,
              nil,
              dismiss,
            },
            {
              layout = wibox.layout.fixed.horizontal,
              spacing = dpi(10),
              {image_n, layout = wibox.layout.fixed.vertical},
              {
                layout = wibox.layout.align.vertical,
                expand = "none",
                nil,
                {
                  layout = wibox.layout.fixed.vertical,
                  title_n,
                  message_n,
                },
                nil,
              },
            },
            {
              {actions, layout = wibox.layout.fixed.vertical},
              margins = {top = dpi(10)},
              visible = n.actions and #n.actions > 0,
              widget = wibox.container.margin
            },
          },
          widget = wibox.container.margin,
          margins = { left = dpi(10), right = dpi(10), bottom = dpi(10)}
        },
      },
      widget          = wibox.container.background,
      bg              = colors.background,
      forced_width    = dpi(340),
      shape           = gears.shape.rounded_rect,
    }
  }
  widget.buttons = {}
  if n.category ~= "music" then
    play_sound(n)
  end
end)

-- error handling
naughty.connect_signal(
	'request::display_error',
	function(message, startup)
		naughty.notification {
			urgency = 'critical',
			title   = 'oops, an error happened'..(startup and ' during startup!' or '!'),
			message = message,
			app_name = 'system notification',
		}
	end
)

-- xdg icon lookup
naughty.connect_signal(
	'request::icon',
	function(n, context, hints)
		if context ~= 'app_icon' then return end

		local path = menubar.utils.lookup_icon(hints.app_icon) or
		menubar.utils.lookup_icon(hints.app_icon:lower())

		if path then
			n.icon = path
		end
	end
)
