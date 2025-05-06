-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- rose-pine theme for wezterm
local theme = wezterm.plugin.require('https://github.com/neapsix/wezterm').main
-- smart-splits for neovim integration
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')

config.colors = theme.colors()
config.window_frame = theme.window_frame()
config.max_fps = 60
config.use_fancy_tab_bar = true
config.window_decorations = 'NONE'
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14.0

config.leader = { key = 'Space', mods = 'CTRL' }
config.keys = {
  { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'h', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = 'LEADER', action = act.SplitPane { direction = 'Right', size = { Percent = 50 } } },
  { key = 'l', mods = 'ALT|SHIFT', action = act.ActivateTabRelative(1) },
  { key = 'h', mods = 'ALT|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },
}

-- configure smart-splits plugin
  -- smart_splits.apply_to_config(config)
smart_splits.apply_to_config(config, {
  direction_keys = { 'h', 'j', 'k', 'l' },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = 'CTRL', -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = 'META', -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
  -- log level to use: info, warn, error
  log_level = 'info',
})

return config
