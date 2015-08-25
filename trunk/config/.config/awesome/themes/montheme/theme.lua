---------------------------
-- Mon thème awesome     --
---------------------------

theme = {}

theme.font          = "sans 8"

theme.bg_normal     = "#330000"
theme.bg_focus      = "#781414"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#440000"

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize  = "#ffffff"

theme.border_width  = "1"
theme.border_normal = "#000000"
theme.border_focus  = "#781414"
theme.border_marked = "#91231c"

-- There are another variables sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.taglist_bg_urgent = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel = "/home/zilbuz/.config/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/home/zilbuz/.config/awesome/themes/default/taglist/squarew.png"

theme.tasklist_floating_icon = "/home/zilbuz/.config/awesome/themes/default/tasklist/floatingw.png"

-- Variables set for theming menu
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/home/zilbuz/.config/awesome/themes/default/submenu.png"
theme.menu_height   = "15"
theme.menu_width    = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/home/zilbuz/.config/awesome/themes/default/titlebar/close.png"
theme.titlebar_close_button_focus = "/home/zilbuz/.config/awesome/themes/default/titlebar/closer.png"

theme.titlebar_ontop_button_normal_inactive = "/home/zilbuz/.config/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = "/home/zilbuz/.config/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/home/zilbuz/.config/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = "/home/zilbuz/.config/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/home/zilbuz/.config/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = "/home/zilbuz/.config/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/home/zilbuz/.config/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = "/home/zilbuz/.config/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/home/zilbuz/.config/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = "/home/zilbuz/.config/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/home/zilbuz/.config/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = "/home/zilbuz/.config/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/home/zilbuz/.config/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = "/home/zilbuz/.config/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/home/zilbuz/.config/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = "/home/zilbuz/.config/awesome/themes/default/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg -a /home/zilbuz/Images/FondsEcran/DualScreen/mandolux-phelps.png" }

-- You can use your own layout icons like this:
theme.layout_fairh = "/home/zilbuz/.config/awesome/themes/default/layouts/fairhw.png"
theme.layout_fairv = "/home/zilbuz/.config/awesome/themes/default/layouts/fairvw.png"
theme.layout_floating = "/home/zilbuz/.config/awesome/themes/default/layouts/floatingw.png"
theme.layout_magnifier = "/home/zilbuz/.config/awesome/themes/default/layouts/magnifierw.png"
theme.layout_max = "/home/zilbuz/.config/awesome/themes/default/layouts/maxw.png"
theme.layout_fullscreen = "/home/zilbuz/.config/awesome/themes/default/layouts/fullscreenw.png"
theme.layout_tilebottom = "/home/zilbuz/.config/awesome/themes/default/layouts/tilebottomw.png"
theme.layout_tileleft = "/home/zilbuz/.config/awesome/themes/default/layouts/tileleftw.png"
theme.layout_tile = "/home/zilbuz/.config/awesome/themes/default/layouts/tilew.png"
theme.layout_tiletop = "/home/zilbuz/.config/awesome/themes/default/layouts/tiletopw.png"
theme.layout_spiral  = "/home/zilbuz/.config/awesome/themes/default/layouts/spiralw.png"
theme.layout_dwindle = "/home/zilbuz/.config/awesome/themes/default/layouts/dwindlew.png"

theme.awesome_icon = "/home/zilbuz/.config/awesome/themes/montheme/icons/awesome16.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
