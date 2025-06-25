local awful = require("awful")
local wibox = require("wibox")
local taglist = require("ui.bar.taglist")
local battery = require("ui.bar.battery")
local colors = require("ui.colors")
local network = require("ui.bar.network")
local distro = require("ui.bar.distro")
local power = require("ui.bar.power")
local bluetooth = require("ui.bar.bluetooth")
local layoutState = require("ui.bar.layout")
local profiles = require("ui.bar.profiles")
local capture = require("ui.bar.capture")

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
        position = "top",
        bg       = colors.nord0,
        screen   = s,
        visible  = true,
        ontop    = false,
        width    = 1920,
        height   = 60,
        type     = "dock",
    }
    local mytextclock = require("ui.bar.clock")



    s.bar:setup {
        layout = wibox.layout.align.horizontal,
        {
            distro,
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            layoutState,
        },

        {
            layout = wibox.layout.align.horizontal,
            nil,      -- left: empty space
            profiles, -- center: your power profile widget (centered)
            nil,      -- right: empty space
        },
        {
            layout = wibox.layout.fixed.horizontal,
            capture,
            bluetooth,
            network,
            battery,
            mytextclock,
            power,
        },
    }
end)
