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

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  local gui_win = window:gui_window()
  local screen = wezterm.gui.screens().active
  local sw = screen.width
  local sh = screen.height
  gui_win:set_inner_size(sw / 2, sh / 2)  -- 縦横それぞれ1/2 = 面積1/4
  gui_win:set_position(sw / 4, sh / 4)    -- 中央に配置
end)

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

config.keys = {
  { key = 'a', mods = 'CTRL', action = wezterm.action.SendString '\x01' }, -- Ctrl-A (行の先頭に移動)
  { key = 'e', mods = 'CTRL', action = wezterm.action.SendString '\x05' }, -- Ctrl-E (行の末尾に移動)
  { key = 'LeftArrow', mods = 'ALT', action = wezterm.action.SendString '\x1bb' }, -- Alt+Left (単語を左に移動)
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.SendString '\x1bf' }, -- Alt+Right (単語を右に移動)
  { key = 'LeftArrow', mods = 'CMD', action = wezterm.action.SendString '\x01' }, -- Cmd+Left (行の先頭に移動)
  { key = 'RightArrow', mods = 'CMD', action = wezterm.action.SendString '\x05' }, -- Cmd+Right (行の末尾に移動)
}

local function is_claude(pane)
  local process = pane:get_foreground_process_info()
  if not process or not process.argv then
    return false
  end
  -- Check if any argument contains "claude"
  for _, arg in ipairs(process.argv) do
    if arg:find("claude") then
      return true
    end
  end
  return false
end
-- Track tabs with bell for highlighting (Claude Code sends BEL alongside OSC 9)
local bell_tabs = {}
wezterm.on("bell", function(window, pane)
  if is_claude(pane) then
    local tab = pane:tab()
    if tab then
      bell_tabs[tab:tab_id()] = true
    end
  end
end)

wezterm.on("format-tab-title", function(tab)
	local tab_id = tab.tab_id

	-- Clear bell state when tab becomes active
	if tab.is_active then
		bell_tabs[tab_id] = nil
	end

	-- Highlight tabs with Claude Code notifications
	if bell_tabs[tab_id] and not tab.is_active then
		local title = (tab.tab_index + 1) .. ": " .. tab.active_pane.title
		return {
			{ Background = { Color = "#e2943b" } },
			{ Foreground = { Color = "#161821" } },
			{ Text = " " .. title .. " " },
		}
	end
end)
config.audible_bell = "Disabled"

-- and finally, return the configuration to wezterm
return config
