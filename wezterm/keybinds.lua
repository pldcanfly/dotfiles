local wezterm = require 'wezterm'
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
local config = wezterm.config_builder()

-- Wezterm Move

local function is_vim(pane)
	local process_info = pane:get_foreground_process_info()
	local process_name = process_info and process_info.name

	return process_name == "nvim" or process_name == "vim"
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end


-- Keybinds
local act = wezterm.action
config.leader = { key = 'Escape', mods = 'CTRL' }
config.keys = {
	{ key = 'x', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
	{ key = 'v', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
	{ key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
	{ key = 'q', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },

	-- move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	-- resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),

	{ key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
	{ key = '[', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
	{ key = ']', mods = 'LEADER', action = act.ActivateTabRelative(1) },
	{
		key = 'e',
		mods = 'LEADER',
		action = act.PromptInputLine {
			description = 'Enter new name for tab',
			action = wezterm.action_callback(function(window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		},
	},
	{
		key = "s",
		mods = "LEADER|CTRL",
		action = wezterm.action.Multiple({
			wezterm.action_callback(function(window, _)
				resurrect.save_state(resurrect.workspace_state.get_workspace_state())
				window:toast_notification('wezterm', 'workspace saved', nil, 2000)
			end),
		}),
	},
	{
		key = "l",
		mods = "LEADER|CTRL",
		action = wezterm.action.Multiple({
			wezterm.action_callback(function(win, pane)
				resurrect.fuzzy_load(win, pane, function(id, label)
					id = string.match(id, "([^/]+)$")
					id = string.match(id, "(.+)%..+$")
					local state = resurrect.load_state(id, "workspace")
					resurrect.workspace_state.restore_workspace(state, {
						relative = true,
						restore_text = true,
						on_pane_restore = resurrect.tab_state.default_on_pane_restore,
					})
				end)
			end),
		}),
	},
}

-- Switch to tabs
for i = 1, 9 do
	table.insert(config.keys, { key = tostring(i), mods = 'LEADER', action = act.ActivateTab(i - 1) })
end



return config
