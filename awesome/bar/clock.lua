local wibox = require("wibox")
local gears = require("gears")

-- Create the base clock widget
local mytextclock = wibox.widget {
    format = " %H : %M ",
    font   = "DaddyTimeMono NF 18",
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
    bg     = "#393552", -- Background color
    fg     = "#bfc9db", -- Text color
    shape  = function(cr, w, h) return gears.shape.rounded_rect(cr, w, h, 10) end,
    widget = wibox.container.background,
}

return styled_clock
