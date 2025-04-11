local awful = require("awful")
local wibox = require("wibox")

local taglist = {}

taglist.create = function(s, modkey)
    return awful.widget.taglist {
        screen          = s,
        filter          = awful.widget.taglist.filter.noempty,
        style           = {
            bg = "#0f0f17",
            bg_focus = "#44415a",
            squares_sel = "",
            squares_unsel = "",
        },
        buttons         = {
            awful.button({}, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),
            awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
        },
        widget_template = {
            {
                {
                    id     = "text_role",
                    widget = wibox.widget.textbox,
                },
                margins = 12,
                widget  = wibox.container.margin,
            },
            id              = "background_role",
            widget          = wibox.container.background,
            create_callback = function(self, t, index, tags)
                self.bg = "#232136"
                self.normal = "#232136"
                self.hover = "#44415a"
                self:connect_signal("mouse::enter", function()
                    self.bg = self.hover
                end)
                self:connect_signal("mouse::leave", function()
                    if not t.selected then
                        self.bg = self.normal
                    end
                end)
            end
        }
    }
end

return taglist
