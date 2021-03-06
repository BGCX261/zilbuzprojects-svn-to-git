-- Awersome rc.lua
--
-- Software dependencies :
--  - Autorun :
--      - urxvt
--      - ncmpcpp
--      - pidgin
--      - chromium-browser
--      - firefox
--      - wicd
--  - MPD Widget :
--      - curl
--  - dmenu prompt :
--      - suckless-tools
--  - Shutdown dialog
--      - zenity
--      - gksudo
--      - dbus
--      - hal
--      - slock


-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Widgets library
require("vicious")
require("obvious.volume_alsa")
require("obvious.battery")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- The default is a dark theme
-- theme_path = "/usr/share/awesome/themes/default/theme.lua"
-- Uncommment this for a lighter theme
-- theme_path = "/usr/share/awesome/themes/sky/theme.lua"

-- Mon thème 
theme_path = "/home/zilbuz/.config/awesome/themes/montheme/theme.lua"

-- Actually load theme
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
explorer = "thunar"

-- Default sound card and channel to use with volume_alsa
sound_card_id = 1
sound_card_channel = "PCM"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Default keyboard layout
kblayout = "bepo"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
	-- Each screen has its own tag table.
	tags[s] = awful.tag({ "1:Sys", "2:WebApps", "3:IM", "4:www", "5:Boulot", "6:Media", 7, 8, 9}, s,
			{
		    		layouts[1], layouts[1], layouts[1],
			    	layouts[1], layouts[1], layouts[1],
			    	layouts[1], layouts[1], layouts[1]
			})
	-- Webapps tag
	awful.tag.setmwfact(0.65, tags[s][2])
        -- IM tag
	awful.tag.setmwfact(0.15, tags[s][3])
        awful.tag.setncol(2, tags[s][3])
        awful.tag.setnmaster(2, tags[s][3])
        -- Web tag
	awful.tag.setmwfact(0.65, tags[s][4])
        -- Work tag
	awful.tag.setmwfact(0.65, tags[s][5])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal },
                                    { "Log out", awful.util.getdir("config") .. "/scripts/shutdown_dialog.sh" }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Creating and setting up the volume_alsa widget
    volalsawidget = obvious.volume_alsa()
    volalsawidget:set_cardid(sound_card_id)
    volalsawidget:set_channel(sound_card_channel)
    volalsawidget:set_term(terminal)
    volalsawidget:set_layout(awful.widget.layout.horizontal.rightleft)

    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        obvious.battery(),
        volalsawidget.widget,
        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end


-- Another wibox for some widgets
bottomwibox = awful.wibox({ position = "bottom", screen = 1 })

    -- {{{ The widgets
        -- RAM widget
        memwidgettext = widget({ type = "textbox" })
        vicious.register( memwidgettext, vicious.widgets.mem, '<span color="white">RAM:</span> $1% ($2Mo/$3Mo) ', 13)
        -- MPD widget
        mpdwidget = widget({ type = "textbox" })
        vicious.register( mpdwidget, vicious.widgets.mpd,
            function (widget, args)
                if args["{State}"] == "Stop" then return ""
                else return '<span color="white">Now Playing:</span> ' ..
                    args["{Artist}"] .. ' - ' .. args["{Title}"] .. " "
                end
            end
            )
        -- HDD widget
        hddwidget = widget({ type = "textbox" })
        vicious.register( hddwidget, vicious.widgets.fs,
            function (widget, args)
                string = '<span color="white">Debian:</span> ' ..
                args["{/ used_gb}"]..'Go/'..args["{/ size_gb}"] ..
                'Go <span color="white">Windows:</span> ' ..
                args["{/media/windows used_gb}"]..'Go/'..args["{/media/windows size_gb}"]..'Go '
                if args["{/media/LaCie-Basile used_gb}"] == nil then
                    string = string
                else
                    string = string .. '<span color="white">Externe:</span> ' ..
                    args["{/media/LaCie-Basile used_gb}"]..'Go/'..
                    args["{/media/LaCie-Basile size_gb}"]..'Go '
                end
                return string
            end,
            13
            )
        -- CPU widget
        cpuwidget = widget({ type = "textbox" })
        vicious.register( cpuwidget, vicious.widgets.cpu, 
            function (widget, args)
                return string.format('<span color="white">CPU:</span> %02d%%(%02d%%|%02d%%) ',
                    args[1], args[2], args[3])
            end
            )
    -- }}}

-- Adding the widgets
bottomwibox.widgets = {
    {
        mpdwidget,
        layout = awful.widget.layout.horizontal.leftright
    },
    hddwidget,
    memwidgettext,
    cpuwidget,
    layout = awful.widget.layout.horizontal.rightleft
}


-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
	-- Global keys
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "Up", function () awful.screen.focus_relative( 1)   end),
    awful.key({ modkey,           }, "Down", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
--    awful.key({ modkey },            "F1",     function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey },   "F1", 
        function() 
            awful.util.spawn( "dmenu_run -i -p 'Run : ' -nb '" ..
                beautiful.bg_normal .. "' -nf '" .. beautiful.fg_normal ..
                "' -sb '" .. beautiful.bg_focus .. "' -sf '" .. 
                beautiful.fg_focus .. "'") 
        end),

    awful.key({ modkey }, "F4",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

	-- Client awful tagging
-- Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

	-- Raccourcis numériques
-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

	-- Raccourcis souris
clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

	-- Raccourcis maison
	globalkeys = awful.util.table.join(globalkeys,
			awful.key({ modkey }, "#49", function() os.execute("mpc toggle") end ),
			awful.key({ modkey }, "e", function () awful.util.spawn(explorer) end),
			awful.key({ modkey, "Shift" }, "Tab", function ()	-- Change the keyboard layout
								if kblayout == "bepo" then
									kblayout = "fr"
									os.execute("setxkbmap fr-latin9")
								elseif kblayout == "fr" then
									kblayout = "bepo"
									os.execute("setxkbmap fr bepo")
								end
							end),
                        awful.key({ }, "#121", function() 
                                obvious.volume_alsa.mute(sound_card_id, sound_card_channel) 
                            end ),
                        awful.key({ }, "#122", function() 
                                obvious.volume_alsa.lower(sound_card_id, sound_card_channel) 
                            end ),
                        awful.key({ }, "#123", function() 
                                obvious.volume_alsa.raise(sound_card_id, sound_card_channel) 
                            end )
		    )

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
        rules = { 
            -- All clients will match this rule.
            { rule = { },
                    properties = {
                            border_width = beautiful.border_width,
                            border_color = beautiful.border_normal,
                            focus = true,
                            keys = clientkeys,
                            buttons = clientbuttons } },
            -- Rules for floating apps
            { rule = { class = "MPlayer" },
                    properties = { floating = true } },
            { rule = { class = "pinentry" },
                    properties = { floating = true } },
            { rule = { class = "gimp" },
                    properties = { floating = true } },
            { rule = { instance = "thunar" },
                    properties = { floating = true } },
            { rule = { instance = "uzbl-core" },
                    properties = { floating = true } },
            -- Floating audio apps
            { rule = { class = "Qjackctl" },
                    properties = { floating = true } },
            { rule = { class = "Patchage" },
                    properties = { floating = true } },
            { rule = { class = "Hydrogen" },
                    properties = { floating = true } },
            { rule = { class = "Seq24" },
                    properties = { floating = true } },
            { rule = { class = "Slgui" },
                    properties = { floating = true } },
            { rule = { class = "Jack-rack" },
                    properties = { floating = true } },
            { rule = { class = "ZynAddSubFX" },
                    properties = { floating = true } },
            { rule = { class = "Qsynth" },
                    properties = { floating = true } },
            { rule = { class = "Ardour" },
                    properties = { floating = true } },
            { rule = { class = "Qtractor" },
                    properties = { floating = true } },
            -- IM properties
            { rule = { instance = "emesene" },
                    properties = { tag = tags[1][3] },
                    callback = awful.client.setslave },
            { rule = { instance = "gajim.py" },
                    properties = { tag = tags[1][3] },
                    callback = awful.client.setslave }

        }
	-- Different rules for different screens
	if screen.count() == 1 then
		-- Rules for one screen
		rules = awful.util.table.join( rules, {
			-- Rules to move applications to a specific tag and screen
			{ rule = { instance = "ncmpcpp" },
				properties = { tag = tags[1][1] } },
			{ rule = { class = "Firefox" },
				properties = { tag = tags[1][4] } },
                        { rule = { instance = "opera" },
                                properties = { tag = tags[1][4] } },
			{ rule = { instance = "Pidgin" },
				properties = { tag = tags[1][3] } },
			{ rule = { class = "Chromium-browser" },
				properties = { tag = tags[1][2] } }
		} )
	elseif screen.count() > 1 then
		-- Rules for two screens
		rules = awful.util.table.join( rules, {
			-- Rules to move applications to a specific tag and screen
			{ rule = { instance = "ncmpcpp" },
				properties = { tag = tags[1][1] } },
			{ rule = { instance = "opera" },
				properties = { tag = tags[1][4] } },
			{ rule = { class = "Firefox" },
				properties = { tag = tags[2][4] } },
			{ rule = { instance = "Pidgin" },
				properties = { tag = tags[1][3] } },
			{ rule = { class = "Chromium-browser" },
				properties = { tag = tags[1][2] } }
		} )
	end

        awful.rules.rules = rules

-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Autorun

-- Autorun ?
autorun = true

-- Apps à lancer au démarrage
autorunApps = 
{
        "/usr/local/bin/launch_jackd",
        "wicd",
        "wicd-client",
	"urxvt -name \"ncmpcpp\" -e \"ncmpcpp\"",
        "chromium-browser",
        "gajim",
        "emesene",
        "opera"
}
-- Fonction pour ne lancer qu'une fois les applications si elles sont déjà lancées
function run_once(prg)
	if not prg then
		do return nil end
	end
	os.execute("x=" .. prg .. "; pgrep -u $USERNAME -x " .. prg .. " || (" .. prg .. " &)")
end

-- Autorun en lui-même
if autorun then
   for app = 1, #autorunApps do
       awful.util.spawn(autorunApps[app])
   end
end
-- }}}

