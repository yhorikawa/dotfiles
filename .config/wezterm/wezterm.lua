-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.color_scheme = 'iceberg-dark'

-- Appearance
config.font = wezterm.font { family = 'UDEV Gothic 35NFLG', weight = 'Bold' }
config.font_size = 14

use_fancy_tab_bar = false

config.window_background_opacity = 0.95
config.window_background_gradient = {
  colors = { '#002916', '#050633', '#37040e' },
  -- colors = { '#003c29', '#302b63', '#5c243e' },
  orientation = {
    Radial = {
      -- Specifies the x coordinate of the center of the circle,
      -- in the range 0.0 through 1.0.  The default is 0.5 which
      -- is centered in the X dimension.
      cx = 0.25,

      -- Specifies the y coordinate of the center of the circle,
      -- in the range 0.0 through 1.0.  The default is 0.5 which
      -- is centered in the Y dimension.
      cy = 0.25,

      -- Specifies the radius of the notional circle.
      -- The default is 0.5, which combined with the default cx
      -- and cy values places the circle in the center of the
      -- window, with the edges touching the window edges.
      -- Values larger than 1 are possible.
      radius = 1.30,
    },
  },
}

-- We'll use Lua's `if` statement to dynamically set the modifier key based on the OS
local open_link_modifier = "CTRL" -- Default to "CTRL" for Linux and Windows
if wezterm.target_triple:find("darwin") then
  -- If the target is Mac, use "CMD" as the open link modifier
  open_link_modifier = "CMD"
end
config.mouse_bindings = {
  -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = wezterm.action.CompleteSelection("PrimarySelection"),
  },

  -- and make CMD-Click open hyperlinks
  {
    event = {Up={streak=1, button="Left"}},
    mods = open_link_modifier,
    action = wezterm.action.OpenLinkAtMouseCursor,
  },

  -- Disable the 'Down' event of CMD-Click to avoid weird program behaviors
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = open_link_modifier,
    action = wezterm.action.Nop,
  }
}

-- and finally, return the configuration to wezterm
return config
