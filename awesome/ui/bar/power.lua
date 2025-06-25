local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local colors = require("ui.colors")

local font = "JetBrainsMono Nerd Font 16"

local wid = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center",
    valign = "center",
    font = font,
    markup = " "
}

local styled = wibox.widget {
    {
        wid,
        left   = 6,
        right  = 6,
        top    = 6,
        bottom = 6,
        widget = wibox.container.margin,

    },
    fg = colors.error,
    widget = wibox.container.background,
}

styled:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.spawn("/home/eliot/.config/rofi/powermenu/powermenu.sh")
    end)
))
return styled
