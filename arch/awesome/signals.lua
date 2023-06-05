local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    if c.floating or c.first_tag.layout.name == "floating" then
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end

    -- c.shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,6) end

    -- weird thing w/ teamviewer, doesn't want to go under other windows
    if c.class == "TeamViewer" then
        c.ontop = not c.ontop
        c.ontop = not c.ontop
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    local close_btn = wibox.container.background(
        awful.titlebar.widget.closebutton(c)
    )
    close_btn:connect_signal("mouse::enter", function(w)
        w.bg = "#FF0000"
    end)
    close_btn:connect_signal("mouse::leave", function(w)
        w.bg = beautiful.bg_normal
    end)

    local min_btn = wibox.container.background(
        awful.titlebar.widget.minimizebutton(c)
    )
    min_btn:connect_signal("mouse::enter", function(w)
        w.bg = beautiful.bg_minimize
    end)
    min_btn:connect_signal("mouse::leave", function(w)
        w.bg = beautiful.bg_normal
    end)

    local max_btn = wibox.container.background(
        awful.titlebar.widget.maximizedbutton(c)
    )
    max_btn:connect_signal("mouse::enter", function(w)
        w.bg = beautiful.bg_minimize
    end)
    max_btn:connect_signal("mouse::leave", function(w)
        w.bg = beautiful.bg_normal
    end)


    awful.titlebar(c, {size = 20}) : setup {
        { -- Left
            {
                awful.titlebar.widget.iconwidget(c),
                margins = 3,
                widget = wibox.container.margin
            },
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                {
                    font = "NotoSans Nerd Font 8",
                    widget = awful.titlebar.widget.titlewidget(c),
                },
                left = 5,
                widget = wibox.container.margin
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            min_btn,
            --awful.titlebar.widget.floatingbutton (c),
            max_btn,
            --awful.titlebar.widget.stickybutton   (c),
            --awful.titlebar.widget.ontopbutton    (c),
            close_btn,
            layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.horizontal
    }
end)

client.connect_signal("property::floating", function(c)
    if c.maximized then
        return
    end 

    if c.floating then
        awful.titlebar.show(c)
        c.height = c.height - 20
    else
        awful.titlebar.hide(c)
    end
end)

tag.connect_signal("property::layout", function(t)
    local clients = t:clients()
    for k,c in pairs(clients) do
        if c.floating or c.first_tag.layout.name == "floating" then
            awful.titlebar.show(c)
        else
            awful.titlebar.hide(c)
        end
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
