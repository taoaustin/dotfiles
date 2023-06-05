local gears = require("gears")
local awful = require("awful")
-- Widget and layout library
local wibox = require("wibox")
local beautiful = require("beautiful")
local lain = require("lain")

local bars = {}

-- Create a textclock widget
local mytextclock = wibox.widget.textclock("%F | %H:%M")


local bat = lain.widget.bat({
    battery = "BAT0",
    settings =
        function()
            --local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc
            local perc = bat_now.perc .. "%"
            if bat_now.ac_status == 1 then
                perc = "" .. perc
            end
            widget:set_markup(perc)
        end,
    full_notify = "off",
})

local cpu = lain.widget.cpu({
    settings =
        function ()
            local usage = string.format(":%2d%%", cpu_now.usage)
            widget:set_markup(usage)
        end
})

local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({modkey}, 1, 
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({modkey}, 3, 
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end
    ),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, 
        function (c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal(
                    "request::activate",
                    "tasklist",
                    {raise = true}
                )
            end
        end
    ),
    awful.button({}, 3, 
        function()
            awful.menu.client_list({theme = {width = 250}})
        end
    ),
    awful.button({}, 4, function () awful.client.focus.byidx(1) end),
    awful.button({}, 5, function () awful.client.focus.byidx(-1) end)
)


function bars.create(s)
    -- Each screen has its own tag table.
    awful.tag({ "1",  "2", "3", "4", "5"}, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating pwhich layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
            awful.button({}, 1, function() awful.layout.inc(1) end),
            awful.button({}, 3, function() awful.layout.inc(-1) end),
            awful.button({}, 4, function() awful.layout.inc(1) end),
            awful.button({}, 5, function() awful.layout.inc(-1) end)
        )
    )
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style = {shape = gears.shape.circle},
        layout = {layout = wibox.layout.flex.horizontal},
        widget_template =
        {
            {
                {
                    id = "text_role",
                    widget = wibox.widget.textbox
                },
                widget = wibox.container.place
            },
            id = "background_role",
            widget = wibox.container.background
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,6) end},
        layout = {
            max_widget_size = 35,
            layout = wibox.layout.flex.horizontal},
        widget_template =
        {
            {
                {
                    {
                        {
                            id = "icon_role",
                            widget = wibox.widget.imagebox
                        },
                        {
                            id = "text_role",
                            widget = wibox.widget.textbox
                        },
                        layout = wibox.layout.fixed.horizontal
                    },
                    widget = wibox.container.place
                },
                margins = 2,
                widget = wibox.container.margin
            },
            id = "background_role",
            widget = wibox.container.background,
        }
    }

    s.mytags = wibox {
        screen = s,
        width = 100,
        height = 20,
        x = s.geometry.x + beautiful.useless_gap,
        y = s.geometry.y + 2 * beautiful.useless_gap,
        ontop = false,
        visible = true,
        --[[shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,6)
        end,--]]
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal
    }
    s.mytags:setup {
        s.mytaglist,
        margins = beautiful.useless_gap,
        widget = wibox.container.margin,
    }
    s.mytags:struts {
        top = s.mytags.height + s.mytags.y +  s.mytags.border_width
    }

    s.mytasks = wibox {
        screen = s,
        width = 200,
        height = s.mytags.height,
        x = s.mytags.x + s.mytags.width + (beautiful.useless_gap + (2 * beautiful.border_width)),
        y = s.mytags.y,
        ontop = false,
        visible = true,
        --[[shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,6)
        end,--]]
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal
    }
    s.mytasks:setup {
        s.mytasklist,
        margins = beautiful.useless_gap,
        widget = wibox.container.margin
    }

   s.mylayout = wibox {
        screen = s,
        width = s.mytags.height,
        height = s.mytags.height,
        x = s.geometry.x + s.geometry.width - s.mytags.height - beautiful.useless_gap - (2 * beautiful.border_width),
        y = s.mytags.y,
        ontop = false,
        visible = true,
        --[[shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,6)
        end,--]]
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
   }
   s.mylayout:setup {
       s.mylayoutbox,
       margins = beautiful.useless_gap,
       widget = wibox.container.margin
   }

   s.systemutilities = wibox {
       screen = s,
       width = 300,
       height = s.mytags.height,
       x = s.mylayout.x - (300 + beautiful.useless_gap + (2 * beautiful.border_width)),
       y = s.mytags.y,
       ontop = false,
       visible = true,
       --[[shape = function(cr,w,h)
           gears.shape.rounded_rect(cr,w,h,6)
       end,--]]
       border_width = beautiful.border_width,
       border_color = beautiful.border_normal,
   }
   s.systemutilities:setup {
       {
           {
               wibox.widget.systray(),
               cpu.widget,
               bat.widget,
               widget = wibox.container.place,
               spacing = 16,
               spacing_widget = wibox.widget.separator,
               layout = wibox.layout.fixed.horizontal
           },
           halign = "right",
           widget = wibox.container.place
       },
       top = beautiful.useless_gap,
       bottom = beautiful.useless_gap,
       left = 6,
       right = 6,
       widget = wibox.container.margin
   }

    s.mydatetime = wibox {
        screen = s,
        width = s.systemutilities.x -
            (s.mytasks.x + s.mytasks.width) -
            (2 * beautiful.useless_gap) -
            (4 * beautiful.border_width),
        --width = 200,
        height = s.mytags.height,
        x = s.mytasks.x + s.mytasks.width + (beautiful.useless_gap + (2 * beautiful.border_width)),
        --x = (s.geometry.width / 2) - (200 / 2),
        y = s.mytags.y,
        ontop = false,
        visible = true,
        bg = beautiful.bg_normal,--"#FFFFFF00",
        fg = beautiful.bg_focus,
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
    }
    s.mydatetime:setup {
        {
            mytextclock,
            layout = wibox.layout.flex.horizontal
        },
        widget = wibox.container.place
    }

    s.mypromptpopup = awful.popup {
        screen = s,
        minimum_height = s.mytasks.height,
        maximum_height = s.mytasks.height,
        x = s.mytasks.x + s.mytasks.width + (beautiful.useless_gap + (3 * beautiful.border_width)),
        y = s.mytasks.y + beautiful.border_width,
        ontop = false,
        visible = true,
        --[[shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,6)
        end,--]]
        widget = {
            s.mypromptbox,
            margins = beautiful.useless_gap,
            widget = wibox.container.margin
        }
    }

end

return bars
