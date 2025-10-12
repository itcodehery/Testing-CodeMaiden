-- Custom Config for Fedora Linux
local wezterm = require 'wezterm'

local config = {
  -- Default shell
  default_prog = { '/bin/bash', '-l' },

  -- Font settings (Arden replace this with the font that you install from nerdfonts.com)
  font = wezterm.font('0xProto Nerd Font', { weight = 'Regular' }),
  font_size = 10.0,

  -- Colors
  color_scheme = 'Catppuccin Mocha',
  bold_brightens_ansi_colors = true,
  debug_key_events = true,

  -- Window settings
  initial_cols = 140,
  initial_rows = 30,
  window_background_opacity = 0.93,
  window_decorations = "RESIZE",
  hide_tab_bar_if_only_one_tab = true,
  enable_tab_bar = true,

  -- Scrollback & bell
  scrollback_lines = 10000,
  enable_scroll_bar = false,
  audible_bell = 'SystemBeep',
  visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 150,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 150,
  },

  -- Launch menu
  launch_menu = {
    { label = 'Bash', args = { '/bin/bash', '-l' } },
    { label = 'Zsh', args = { '/usr/bin/zsh', '-l' } },
    { label = 'Fish', args = { '/usr/bin/fish', '-l' } },
  },
}

-- Custom key bindings
config.keys = {
  -- Split panes
  { key = 'd', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'CTRL|ALT',   action = wezterm.action.SplitVertical   { domain = 'CurrentPaneDomain' } },

  -- Navigate panes
  { key = 'h', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },
  
  -- Close pane
  { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = false } },
}

-- Status bar: date/time + battery
wezterm.on('update-right-status', function(window, _)
  local date = wezterm.strftime '%Y-%m-%d %H:%M:%S'
  local battery = ''

  for _, b in ipairs(wezterm.battery_info()) do
    battery = string.format('%.0f%%', b.state_of_charge * 100)
  end

  local status = (battery ~= '' and (battery .. ' | ' .. date)) or date
  window:set_right_status(wezterm.format { { Text = status .. ' ' } })
end)

return config
