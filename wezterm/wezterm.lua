local wezterm = require("wezterm")
local mux = wezterm.mux
local config = {}

config.set_environment_variables = { COLORTERM = "truecolor" }
config.term = "xterm-256color"
config.color_scheme = "Cyberdyne"
config.font = wezterm.font("JetBrains Mono Nerd Font")
config.font_size = 14.0

-- [[ APARIENCIA Y "CHROME" ]]
-- Esto permite que la ventana se pegue perfectamente a la barra de GNOME
config.window_decorations = "NONE"

-- [[ SOLUCIÓN: LUZ TOTAL PARA PANELES INACTIVOS ]]
-- Esto mata el filtro oscuro de WezTerm. Todos los paneles tendrán el mismo color y brillo.
config.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 1.0,
}

-- TRANSPARENCIA GLOBAL
config.window_background_opacity = 0.85
config.text_background_opacity = 1.0

-- ADIÓS A LA BARRA GRIS
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- [[ COLORES Y EL INDICADOR ROJO ]]
config.colors = {
	tab_bar = {
		background = "rgba(21, 17, 68, 0.85)",
		active_tab = {
			bg_color = "#00f0ff",
			fg_color = "#0b0814",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#1a0b1c",
			fg_color = "#ff003c",
		},
		inactive_tab_hover = {
			bg_color = "#ff003c",
			fg_color = "#0b0814",
		},
	},

	-- EL INDICADOR: Cursor rojo neón brillante en la ventana activa
	cursor_bg = "#ff003c",
	cursor_border = "#ff003c",
	cursor_fg = "#0b0814",

	-- Opcional: Las líneas divisorias entre paneles en un color discreto
	split = "#1a0b1c",
}

-- Padding interno (no afecta el borde exterior contra GNOME)
config.window_padding = { left = 30, right = 30, top = 30, bottom = 30 }
config.initial_cols = 110
config.initial_rows = 30

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	gui_window:maximize()
end)

return config
