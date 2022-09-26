local awful = require("awful")
local ruled = require("ruled")

ruled.client.connect_signal('request::rules', function()
  -- All clients will match this rule.
  ruled.client.append_rule{
    id         = 'global',
    rule       = {},
    properties = {
      focus     = awful.client.focus.filter,
      raise     = true,
      screen    = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  }

  -- Floating clients.
  ruled.client.append_rule{
    id = 'floating',
    rule_any = {
      instance = {'copyq', 'pinentry'},
      type = {
        'popup_menu',
        'dropdown_menu',
        'toolbar',
        'dialog',
        'menu',
        'notification',
      },
      class = {
        'Arandr',
        'Blueman-manager',
        'Gpick',
        'Kruler',
        'Sxiv',
        'Tor Browser',
        'Wpa_gui',
        'veromix',
        'xtightvncviewer',
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        'Event Tester',  -- xev.
      },
      role = {
        'AlarmWindow',    -- Thunderbird's calendar.
        'ConfigManager',  -- Thunderbird's about:config.
        'pop-up',         -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = {floating = true}
  }

  -- Add titlebars to normal clients and dialogs
  ruled.client.append_rule{
    id         = 'titlebars',
    rule_any   = {type = {'normal', 'dialog'}},
    properties = {titlebars_enabled = false},
  }

  -- Set Firefox to always map on the tag named '2' on screen 1.
  -- ruled.client.append_rule {
  --    rule       = {class = 'Firefox'},
  --    properties = {screen = 1, tag = '2'}
  -- }
  ruled.client.append_rule{
    id = 'teams',
    rule_any = {
      class = {'microsoft teams - preview'}
    },
    properties = {tag = screen[1].tags[7]}
  }
end)
