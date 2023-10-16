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

-- For example, changing the color scheme:
config.color_scheme = 'Google Dark (base16)'
config.font = wezterm.font 'JetBrains Mono'
config.automatically_reload_config = true
config.window_background_opacity = 0.8
config.window_background_image = '/home/ben/Pictures/star_trek_in_black_background_hd_star_trek-1920x1080.jpg'
config.window_background_image_hsb = {
  -- Darken the background image by reducing it to 1/3rd
  brightness = 0.2,

  -- You can adjust the hue by scaling its value.
  -- a multiplier of 1.0 leaves the value unchanged.
  hue = 1.0,

  -- You can adjust the saturation also.
  saturation = 1.0,
}
config.text_background_opacity = 0.8

-- and finally, return the configuration to wezterm
return config

