local beautiful = require("beautiful")

_M = {}

_M.osd_popup = require(... .. ".osd-" .. beautiful.chosen_osd_style)
_M.colorscheme_popup = require(... .. ".colorscheme_popup")

return _M
