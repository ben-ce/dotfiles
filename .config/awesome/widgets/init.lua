local _M = {}

local awful = require'awful'
local gears = require'gears'
local hotkeys_popup = require'awful.hotkeys_popup'
local beautiful = require'beautiful'
local wibox = require'wibox'
local dpi = beautiful.xresources.apply_dpi
local apps = require'config.apps'
local mod = require'bindings.modkeys'
local clickable_container = require("widgets.clickable-container")
local animation = require("modules.animation")

_M.button = require("widgets.button")
_M.text = require("widgets.text")

_M.awesomemenu = {
   {'hotkeys', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
   {'manual', apps.manual_cmd},
   {'edit config', apps.editor_cmd .. ' ' .. awesome.conffile},
   {'restart', awesome.restart},
   {'quit', function() awesome.quit() end},
}

_M.mainmenu = awful.menu{
   items = {
      {'awesome', _M.awesomemenu, beautiful.awesome_icon},
      {'open terminal', apps.terminal}
   }
}

_M.launcher = awful.widget.launcher{
   image = beautiful.menu_icon,
   menu = _M.mainmenu
}

_M.keyboardlayout = awful.widget.keyboardlayout()

function _M.create_keyboardlayout()
  return _M.button.elevated.state({
    child = _M.keyboardlayout,
    normal_bg = beautiful.bg_normal,
  })
end

 --  ____            _
 -- / ___| _   _ ___| |_ _ __ __ _ _   _
 -- \___ \| | | / __| __| '__/ _` | | | |
 --  ___) | |_| \__ \ |_| | | (_| | |_| |
 -- |____/ \__, |___/\__|_|  \__,_|\__, |
 --        |___/                   |___/

function _M.create_systray(s)
	local mysystray = wibox.widget.systray()
	mysystray.base_size = beautiful.systray_icon_size

	local widget = wibox.widget({
		widget = wibox.container.constraint,
		strategy = "max",
		width = dpi(0),
		{
			widget = wibox.container.margin,
			margins = dpi(10),
			mysystray,
		},
	})

	local system_tray_animation = animation:new({
		easing = animation.easing.linear,
		duration = 0.125,
		update = function(self, pos)
			widget.width = pos
		end,
	})

	local arrow = _M.button.text.state({
		text_normal_bg = beautiful.accent,
		normal_bg = beautiful.wibar_bg,
		font = beautiful.icon_font .. "Round ",
		size = 18,
		text = "",
		on_turn_on = function(self)
			system_tray_animation:set(400)
			self:set_text("")
		end,
		on_turn_off = function(self)
			system_tray_animation:set(0)
			self:set_text("")
		end,
	})

	return wibox.widget({
    screen = s,
		layout = wibox.layout.fixed.horizontal,
		arrow,
		widget,
	})
end

function _M.create_promptbox() return awful.widget.prompt() end

function _M.create_layoutbox(s)
   return awful.widget.layoutbox{
      screen = s,
      buttons = {
         awful.button{
            modifiers = {},
            button    = 1,
            on_press  = function() awful.layout.inc(1) end,
         },
         awful.button{
            modifiers = {},
            button    = 3,
            on_press  = function() awful.layout.inc(-1) end,
         },
         awful.button{
            modifiers = {},
            button    = 4,
            on_press  = function() awful.layout.inc(-1) end,
         },
         awful.button{
            modifiers = {},
            button    = 5,
            on_press  = function() awful.layout.inc(1) end,
         },
      }
   }
end

 --  _____           _ _     _
 -- |_   _|_ _  __ _| (_)___| |_
 --   | |/ _` |/ _` | | / __| __|
 --   | | (_| | (_| | | \__ \ |_
 --   |_|\__,_|\__, |_|_|___/\__|
 --            |___/
local taglist_padding = 10

function _M.create_taglist(s)
   return awful.widget.taglist{
      screen = s,
      filter = awful.widget.taglist.filter.all,
      style = {
       shape = gears.shape.rounded_rect
      },
      widget_template = {
        {
          {
            id = 'text_role',
            widget = wibox.widget.textbox
          },
          left = dpi(taglist_padding),
          right = dpi(taglist_padding),
          widget = wibox.container.margin
        },
        id = 'background_role',
        widget = wibox.container.background
      },
      buttons = {
         awful.button{
            modifiers = {},
            button    = 1,
            on_press  = function(t) t:view_only() end,
         },
         awful.button{
            modifiers = {mod.super},
            button    = 1,
            on_press  = function(t)
               if client.focus then
                  client.focus:move_to_tag(t)
               end
            end,
         },
         awful.button{
            modifiers = {},
            button    = 3,
            on_press  = awful.tag.viewtoggle,
         },
         awful.button{
            modifiers = {mod.super},
            button    = 3,
            on_press  = function(t)
               if client.focus then
                  client.focus:toggle_tag(t)
               end
            end
         },
         awful.button{
            modifiers = {},
            button    = 4,
            on_press  = function(t) awful.tag.viewprev(t.screen) end,
         },
         awful.button{
            modifiers = {},
            button    = 5,
            on_press  = function(t) awful.tag.viewnext(t.screen) end,
         },
      }
   }
end

function _M.create_tasklist(s)
   return awful.widget.tasklist{
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = {
      awful.button{
        modifiers = {},
        button    = 1,
        on_press  = function(c)
          c:activate{context = 'tasklist', action = 'toggle_minimization'}
        end,
      },
      awful.button{
        modifiers = {},
        button    = 3,
        on_press  = function() awful.menu.client_list{theme = {width = 250}}   end,
      },
      awful.button{
        modifiers = {},
        button    = 4,
        on_press  = function() awful.client.focus.byidx(-1) end
      },
      awful.button{
        modifiers = {},
        button    = 5,
        on_press  = function() awful.client.focus.byidx(1) end
      },
    },
    layout   = {
    spacing_widget = {
        {
            forced_width  = 5,
            shape = gears.shape.circle,
            widget        = wibox.widget.separator
        },
        valign = "center",
        halign = "center",
        widget = wibox.container.place,
    },
    spacing = 10,
    layout  = wibox.layout.fixed.horizontal
    },
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
      {
        wibox.widget.base.make_widget(),
        forced_height = 5,
        id            = "background_role",
        widget        = wibox.container.background,
      },
      {
        awful.widget.clienticon,
        margins = 5,
        widget  = wibox.container.margin
      },
      nil,
      layout = wibox.layout.align.vertical,
    }
  }
end

function _M.create_tasklist2(s)
  return awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.currenttags,
    buttons  = tasklist_buttons,
    style    = {
        shape_border_width = 1,
        shape_border_color = '#777777',
        shape  = gears.shape.rounded_bar,
    },
    layout   = {
        spacing = 10,
        spacing_widget = {
            {
                forced_width = 5,
                shape        = gears.shape.circle,
                widget       = wibox.widget.separator
            },
            valign = 'center',
            halign = 'center',
            widget = wibox.container.place,
        },
        layout  = wibox.layout.flex.horizontal
    },
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
        {
            {
                {
                    {
                        id     = 'icon_role',
                        widget = wibox.widget.imagebox,
                    },
                    margins = 2,
                    widget  = wibox.container.margin,
                },
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 10,
            right = 10,
            widget = wibox.container.margin
        },
        id     = 'background_role',
        widget = wibox.container.background,
    },
  }
end

function _M.create_wibox(s)
   return awful.wibar{
      screen = s,
      position = 'top',
      widget = {
         layout = wibox.layout.align.horizontal,
         expand = 'none',
         -- left widgets
         {
            layout = wibox.layout.fixed.horizontal,
            _M.launcher,
            s.taglist,
            s.promptbox,
         },
         -- middle widgets
         require("widgets.clock")(s),
         -- right widgets
         {
            layout = wibox.layout.fixed.horizontal,
            s.kblayout,
            s.systray,
            -- s.volume,
            require("widgets.pipewire"),
            -- s.battery,
            require("widgets.battery"),
            s.layoutbox,
         }
      }
   }
end

return _M
