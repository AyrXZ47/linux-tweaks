-- Importar la librería de wezterm
local wezterm = require("wezterm")
-- Importar el multiplexor (NECESARIO para el script de inicio)
local mux = wezterm.mux

-- Esta es la tabla donde va toda la configuración
local config = {}

-- [[ TEMA Y COLORES ]]
config.color_scheme = "Cyberdyne"

-- [[ FUENTES ]]
config.font = wezterm.font("JetBrains Mono Nerd Font")
config.font_size = 16.0

-- [[ APARIENCIA Y "CHROME" ]]
config.window_background_opacity = 0.66
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

-- [[ EVENTO DE INICIO PARA FORZAR MAXIMIZADO ]]
-- Esta es la versión corregida que usa "maximize()"
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	-- Esta es la acción de "Maximizar" que querías
	gui_window:maximize()
end)

-- ¡Devolvemos la configuración para que WezTerm la aplique!
return config
