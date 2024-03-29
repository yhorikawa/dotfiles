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
config.initial_rows = 40
config.initial_cols = 120
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

-- and finally, return the configuration to wezterm
return config
