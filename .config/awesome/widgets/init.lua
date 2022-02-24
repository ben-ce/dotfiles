local _M = {}

local awful = require'awful'
local gears = require'gears'
local hotkeys_popup = require'awful.hotkeys_popup'
local beautiful = require'beautiful'
local wibox = require'wibox'
local dpi = beautiful.xresources.apply_dpi
local apps = require'config.apps'
local mod = require'bindings.modkeys'

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
_M.textclock      = wibox.widget.textclock()

-- Create a containger for the systray to apply margins
_M.tray = wibox.widget{
   {
    widget = wibox.widget.systray
   },
      left = 6,
      right = 6,
      top = 6,
      bottom = 6,
      widget = wibox.container.margin
}

_M.volume = wibox.widget{
  {
  widget = require("widgets.pipewire")({icon = beautiful.widget_vol, font = beautiful.font, space = beautiful.widget_icon_gap})
  },
      left = 6,
      right = 6,
      top = 6,
      bottom = 6,
      widget = wibox.container.margin
}

_M.battery = wibox.widget{
  {
  widget = require("widgets.battery")
  },
      left = 6,
      right = 6,
      top = 6,
      bottom = 6,
      widget = wibox.container.margin
}

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

local taglist_padding = 10

function _M.create_taglist(s)
   return awful.widget.taglist{
      screen = s,
      filter = awful.widget.taglist.filter.all,
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
  }
end

function _M.create_wibox(s)
   return awful.wibar{
      screen = s,
      position = 'top',
      widget = {
         layout = wibox.layout.align.horizontal,
         -- left widgets
         {
            layout = wibox.layout.fixed.horizontal,
            _M.launcher,
            s.taglist,
            s.promptbox,
         },
         -- middle widgets
         s.tasklist,
         -- right widgets
         {
            layout = wibox.layout.fixed.horizontal,
            _M.keyboardlayout,
            _M.tray,
            _M.volume,
            _M.battery,
            require("widgets.calendar").create(s),
            s.layoutbox,
         }
      }
   }
end

return _M
