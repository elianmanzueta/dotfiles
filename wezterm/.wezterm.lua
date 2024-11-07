local wezterm = require("wezterm")
local config = {}

-- WSL
config.default_domain = "WSL:Arch"

-- Apperance
config.color_scheme = "duckbones"
config.font = wezterm.font("JetBrains Mono")

-- Keys
config.keys = {
	-- Panes
	{ key = "s", mods = "CTRL|ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "CTRL|ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "w", mods = "CTRL|ALT", action = wezterm.action.CloseCurrentPane { confirm = false } },
}

return config
