local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local colors = require("ui.colors")


local widget = wibox.widget {
    font         = "JetBrains Mono Nerd Font 16",
    forced_width = 27,
    widget       = wibox.widget.textbox,
    align        = "center",
    valign       = "center",
    markup       = "󰣇"
}


local styled = wibox.widget {
    {
        widget,
        left   = 6,
        right  = 10,
        top    = 6,
        bottom = 6,
        widget = wibox.container.margin,

    },
    fg = colors.nord8,
    widget = wibox.container.background,
}

styled:buttons { gears.table.join(awful.button({}, 1, function()
    awful.spawn("rofi -show drun")
end)) }

return styled
