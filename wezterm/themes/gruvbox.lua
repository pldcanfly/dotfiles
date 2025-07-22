local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- config.color_scheme = 'Monokai Soda'
-- config.color_scheme = 'Breath Darker (Gogh)'
config.color_scheme = "Gruvbox Dark (Gogh)"
config.font = wezterm.font("HackNerdFont")

-- Tabbar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
-- config.cursor_blink_rate = 1000
-- config.default_cursor_style = 'BlinkingBlock'
-- config.window_decorations = 'RESIZE'

-- config.colors = {
-- 	tab_bar = {
-- 		-- The color of the strip that goes along the top of the window
-- 		-- (does not apply when fancy tab bar is in use)
-- 		background = '#0b0022',
--
-- 		-- The active tab is the one that has focus in the window
-- 		active_tab = {
-- 			-- The color of the background area for the tab
-- 			bg_color = 'blue',
-- 			-- The color of the text for the tab
-- 			fg_color = 'yellow',
--
-- 			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
-- 			-- label shown for this tab.
-- 			-- The default is "Normal"
-- 			intensity = 'Normal',
--
-- 			-- Specify whether you want "None", "Single" or "Double" underline for
-- 			-- label shown for this tab.
-- 			-- The default is "None"
-- 			underline = 'None',
--
-- 			-- Specify whether you want the text to be italic (true) or not (false)
-- 			-- for this tab.  The default is false.
-- 			italic = false,
--
-- 			-- Specify whether you want the text to be rendered with strikethrough (true)
-- 			-- or not for this tab.  The default is false.
-- 			strikethrough = false,
-- 		},
--
-- 		-- Inactive tabs are the tabs that do not have focus
-- 		inactive_tab = {
-- 			bg_color = '#1b1032',
-- 			fg_color = '#808080',
--
-- 			-- The same options that were listed under the `active_tab` section above
-- 			-- can also be used for `inactive_tab`.
-- 		},
--
-- 		-- You can configure some alternate styling when the mouse pointer
-- 		-- moves over inactive tabs
-- 		inactive_tab_hover = {
-- 			bg_color = '#3b3052',
-- 			fg_color = '#909090',
-- 			italic = true,
--
-- 			-- The same options that were listed under the `active_tab` section above
-- 			-- can also be used for `inactive_tab_hover`.
-- 		},
--
-- 		-- The new tab button that let you create new tabs
-- 		new_tab = {
-- 			bg_color = '#1b1032',
-- 			fg_color = '#808080',
--
-- 			-- The same options that were listed under the `active_tab` section above
-- 			-- can also be used for `new_tab`.
-- 		},
--
-- 		-- You can configure some alternate styling when the mouse pointer
-- 		-- moves over the new tab button
-- 		new_tab_hover = {
-- 			bg_color = '#3b3052',
-- 			fg_color = '#909090',
-- 			italic = true,
--
-- 			-- The same options that were listed under the `active_tab` section above
-- 			-- can also be used for `new_tab_hover`.
-- 		},
-- 	},
-- }

wezterm.on("update-status", function(window, pane)
	local elements = {}

	local url = pane:get_current_working_dir()

	table.insert(elements, { Foreground = { Color = "gray" } })
	table.insert(elements, { Text = url.path })
	table.insert(elements, "ResetAttributes")
	table.insert(elements, { Text = " // " })
	table.insert(elements, { Foreground = { Color = "green" } })
	table.insert(elements, { Text = window:active_workspace() })
	table.insert(elements, "ResetAttributes")

	if window:leader_is_active() then
		table.insert(elements, { Text = " // " })
		table.insert(elements, { Foreground = { Color = "yellow" } })
		table.insert(elements, { Text = "󰃀 " })
		table.insert(elements, "ResetAttributes")
	end

	window:set_right_status(wezterm.format(elements))
end)

return config
