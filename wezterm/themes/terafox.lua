local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'carbonfox'
config.font = wezterm.font('Hack')


-- Tabbar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true
-- config.cursor_blink_rate = 1000
-- config.default_cursor_style = 'BlinkingBlock'
-- config.window_decorations = 'RESIZE'

wezterm.on('update-status', function(window, pane)
	local elements = {}


	local url = pane:get_current_working_dir()

	table.insert(elements, { Foreground = { Color = 'gray' } })
	table.insert(elements, { Text = url.path })
	table.insert(elements, 'ResetAttributes')
	table.insert(elements, { Text = ' // ' })
	table.insert(elements, { Foreground = { Color = 'green' } })
	table.insert(elements, { Text = window:active_workspace() })
	table.insert(elements, 'ResetAttributes')

	if window:leader_is_active() then
		table.insert(elements, { Text = ' // ' })
		table.insert(elements, { Foreground = { Color = 'yellow' } })
		table.insert(elements, { Text = '󰃀 '
		})
		table.insert(elements, 'ResetAttributes')
	end

	window:set_right_status(wezterm.format(elements))
end)


return config
