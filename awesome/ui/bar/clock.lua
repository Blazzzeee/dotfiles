local wibox = require("wibox")
local gears = require("gears")
local colors = require("ui.colors")
-- Create the base clock widget
local mytextclock = wibox.widget {
    format = "|    %H : %M ",
    font   = "DaddyTimeMono NF 16",
    align  = "center",
    valign = "center",
    widget = wibox.widget.textclock,
}
local styled_clock = wibox.widget {
    {
        mytextclock,
        left   = 14,
        right  = 14,
        top    = 6,
        bottom = 6,
        widget = wibox.container.margin,
    },
    fg     = colors.white,
    shape  = function(cr, w, h) return gears.shape.rounded_rect(cr, w, h, 10) end,
    widget = wibox.container.background,
}

return styled_clock
