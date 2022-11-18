local taglists = {
  'simple', -- 1
  'animated', -- 2
  'circle-animated' -- 3
}

local chosen_taglist = require(... .. ".taglist-" .. taglists[2])

return chosen_taglist
