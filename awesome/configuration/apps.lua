local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. "utilities/"

return {
	--- Default Applications
	default = {
		--- Default terminal emulator
		terminal = "kitty",
		--- Default music client
		music_player = "kitty ncmpcpp",
		--- Default text editor
		text_editor = "kitty nvim",
		--- Default code editor
		code_editor = "code",
		--- Default web browser
		web_browser = "firefox",
		--- Default file manager
		file_manager = "thunar",
		--- Default network manager
		network_manager = "nm-applet",
		--- Default bluetooth manager
		bluetooth_manager = "blueman-manager",
		--- Default power manager
		power_manager = "xfce4-power-manager",
		--- Default rofi global menu
		app_launcher =
		"rofi -show drun -config ~/.config/rofi/config.rasi -no-history -matching prefix -drun-match-fields name -no-tokenize"
	},

	--- List of binaries/shell scripts that will execute for a certain task
	utils = {
		--- Fullscreen screenshot
		full_screenshot = utils_dir .. "screensht full",
		--- Area screenshot
		area_screenshot = utils_dir .. "screensht area",
		--- Color Picker
		color_picker = utils_dir .. "xcolor-pick",
	},
}
