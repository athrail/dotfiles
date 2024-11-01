-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = 'Tokyo Night'
config.max_fps = 60
config.use_fancy_tab_bar = false
config.window_decorations = 'NONE'

config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}

config.leader = { key = 'Space', mods = 'CTRL' }
config.keys = {
  -- new tab
  {
    key = 'c',
    mods = 'LEADER',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'v',
    mods = 'LEADER',
    action = act.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  {
    key = 'L',
    mods = 'ALT|SHIFT',
    action = act.ActivateTabRelative(1),
  },
  {
    key = 'H',
    mods = 'ALT|SHIFT',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = 'H',
    mods = 'CTRL',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'J',
    mods = 'CTRL',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = 'K',
    mods = 'CTRL',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'L',
    mods = 'CTRL',
    action = act.ActivatePaneDirection 'Right',
  },
}

return config
