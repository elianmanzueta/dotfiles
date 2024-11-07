local wezterm = require("wezterm")
local config = {}

--x86_64-pc-windows-msvc - Windows
-- x86_64-apple-darwin - macOS (Intel)
-- aarch64-apple-darwin - macOS (Apple Silicon)
-- x86_64-unknown-linux-gnu - Linux

-- WSL
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_domain = "WSL:Arch"
end

-- Apperance
config.color_scheme = "duckbones"
config.font = wezterm.font("JetBrains Mono")

-- Keys
config.keys = {
	-- Panes
	{ key = "s", mods = "CTRL|ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "CTRL|ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "w", mods = "CTRL|ALT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
}

return config
