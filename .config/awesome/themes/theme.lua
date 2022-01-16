local gears = require("gears")
local lain  = require("lain")
local bling = require("bling")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local awesome, client, os = awesome, client, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes"
-- theme.font                                      = "JetBrainsMono NF 10"
theme.font                                      = "Sans 8"
theme.fg_normal                                 = "#ebdbb2"
theme.fg_focus                                  = "#ebdbb2"
theme.bg_normal                                 = "#272727"
theme.bg_focus                                  = "#272727"
theme.fg_urgent                                 = "#272727"
theme.bg_urgent                                 = "#FFFFFF"
theme.border_width                              = dpi(2)
theme.border_normal                             = "#272727"
theme.border_focus                              = "#8ec07b"
theme.tasklist_fg_focus                         = "#8ec07b"
theme.taglist_fg_focus                          = "#FFFFFF"
theme.taglist_bg_focus                          = "#272727"
theme.taglist_bg_normal                         = "#272727"
theme.titlebar_bg_focus                         = "#272727"
theme.titlebar_bg_focus                         = "#272727"
theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(130)
theme.tasklist_disable_icon                     = true
theme.awesome_icon                              = theme.dir .."/icons/awesome.png"
theme.layout_tile                               = theme.dir .. "/icons/awesome.png"
theme.useless_gap                               = 6
theme.titlebar_close_button_focus               = theme.dir .. "/icons/close.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/close.png"
gears.wallpaper.maximized(theme.dir .. "/wallpaper.jpg", s)


local markup = lain.util.markup
local blue   = theme.fg_focus
local red    = "#fb4833"
local green  = "#b8ba25"

-- date/clock
local clock = awful.widget.watch(
    "date +'%a %d %b %I:%M '", 60,
        function(widget, stdout)
		        widget:set_markup(" " .. markup.font(theme.font, stdout))
			    end
			    )

-- volume bar
local volicon = wibox.widget.imagebox(theme.vol)
theme.volume = lain.widget.alsabar {
    width = dpi(59), border_width = 0, ticks = true, ticks_size = dpi(6),
    notification_preset = { font = theme.font },
    --togglechannel = "IEC958,3",
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(theme.vol_mute)
        elseif volume_now.level == 0 then
            volicon:set_image(theme.vol_no)
        elseif volume_now.level <= 50 then
            volicon:set_image(theme.vol_low)
        else
            volicon:set_image(theme.vol)
        end
    end,
    colors = {
        background   = theme.bg_normal,
        mute         = red,
        unmute       = theme.border_focus,
    }
}
theme.volume.bar:buttons(my_table.join (
          awful.button({}, 1, function()
            awful.spawn(string.format("%s -e alsamixer", awful.util.terminal))
            theme.volume.update()
          end),
          awful.button({}, 2, function()
            os.execute(string.format("%s set %s 100%%", theme.volume.cmd, theme.volume.channel))
            theme.volume.update()
          end),
          awful.button({}, 3, function()
            awful.spawn(string.format("%s -e alsamixer", awful.util.terminal))
          end),
          awful.button({}, 4, function()
            os.execute(string.format("%s set %s 1%%+", theme.volume.cmd, theme.volume.channel))
            theme.volume.update()
          end),
          awful.button({}, 5, function()
            os.execute(string.format("%s set %s 1%%-", theme.volume.cmd, theme.volume.channel))
            theme.volume.update()
          end)
))
local volume = wibox.container.margin(
wibox.container.background(theme.volume.bar, "#474747", gears.shape.rectangle),
dpi(8), dpi(8), dpi(7), dpi(6))

-- Separators
local spr   = wibox.widget.textbox(markup.font("Terminus 3", " ") .. markup.fontfg(theme.font, "#777777", "|") .. markup.font("Terminus 5", " "))

-- CPU
local cpu = lain.widget.cpu({
	settings = function()
		widget:set_markup(markup.fontfg("Sans 8", "#fb4833", "   " .. cpu_now.usage .. "%  "))
	end
})

-- Memory
local memory = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg("Sans 8", "#fabc2e", "   " .. mem_now.perc .. "%  "))
    end
})

-- Battery
bat_widget = wibox.widget.textbox()
function set_bat(bat_widget)
    local s = ""
    local output = io.popen("acpi"):read()
    local percentage = string.match(output, ".-(%d+)%%")
    s = string.format("   %s%%  ", percentage)
    bat_widget:set_text(s)
end
set_bat(bat_widget)
bat_timer = timer({ timeout = 10 })
bat_timer:connect_signal("timeout", function()
    set_bat(bat_widget)
end)
bat_timer.start(bat_timer)

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.focused, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", ontop = true, screen = s, opacity = 1, height = dpi(24), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- s.mylayoutbox,
            -- spr,
            s.mytaglist,
	    s.mypromptbox,
	    spr,
        },
        s.mytasklist,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            --wibox.widget.systray(),
	    spr,
	    cpu,
	    spr,
	    memory,
	    spr,
	    bat_widget,
	    spr,
	    volume,
            clock,
        },
    }
end

return theme
