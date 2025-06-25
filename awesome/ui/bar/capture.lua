local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local colors = require("ui.colors") -- your colors module

-- Create a text widget that looks like your clock, but says "📸"
local screenshot_widget = wibox.widget {
    {
        {
            text   = " 󰆞 ",
            font   = "JetBrains Mono Nerd Font 16",
            align  = "center",
            valign = "center",
            widget = wibox.widget.textbox,
        },
        left   = 8,
        right  = 8,
        top    = 6,
        bottom = 6,
        widget = wibox.container.margin,
    },
    fg     = colors.nord4,
    shape  = function(cr, w, h) return gears.shape.rounded_rect(cr, w, h, 10) end,
    widget = wibox.container.background,
}

screenshot_widget:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then -- left click
        awful.spawn("/home/eliot/.config/rofi/applets/screenshot.sh")
    end
end)

return screenshot_widget
