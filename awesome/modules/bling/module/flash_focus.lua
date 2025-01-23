local gears = require("gears")
local beautiful = require("beautiful")

local op = beautiful.flash_focus_start_opacity or 0.6
local stp = beautiful.flash_focus_step or 0.01

local flashfocus = function(c)
    -- do nothing
end

local enable = function()
    client.connect_signal("focus", flashfocus)
end
local disable = function()
    client.disconnect_signal("focus", flashfocus)
end

return { enable = enable, disable = disable, flashfocus = flashfocus }
