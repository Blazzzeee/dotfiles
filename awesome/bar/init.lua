local awful = require("awful")
local wibox = require("wibox")
local taglist = require("bar.taglist")

modkey = "Mod4"

screen.connect_signal("request::desktop_decoration", function(s)
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    s.mypromptbox = awful.widget.prompt()

    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({}, 1, function() awful.layout.inc(1) end),
            awful.button({}, 3, function() awful.layout.inc(-1) end),
            awful.button({}, 4, function() awful.layout.inc(-1) end),
            awful.button({}, 5, function() awful.layout.inc(1) end),
        }
    }

    s.mytaglist = taglist.create(s, modkey)


    -----------------------------------------------------------------------------
    -- Bar
    -----------------------------------------------------------------------------

    s.bar = awful.wibar {
        bg       = "#232136",
        position = "top",
        screen   = s,
        visible  = true,
        ontop    = false,
        width    = 1920,
        height   = 40,
        type     = "dock",
    }
    local mytextclock = require("bar.clock")
    s.bar:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
        },
        {
            layout = wibox.layout.fixed.horizontal,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            mytextclock,
        },
    }
end)
