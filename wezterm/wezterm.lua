local wezterm = require("wezterm")
local mux = wezterm.mux
local config = {}

config.set_environment_variables = { COLORTERM = "truecolor" }
config.term = "xterm-256color"
config.color_scheme = "Cyberdyne"
config.font = wezterm.font("JetBrains Mono Nerd Font")
config.font_size = 16.0

-- [[ APARIENCIA Y "CHROME" ]]
config.window_decorations = "NONE"

-- 1. ADIÓS A LA BARRA GRIS
-- Desactivamos la barra gruesa para usar la versión plana y coloreable
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false -- Cámbialo a true si quieres que desaparezca cuando solo hay 1 pestaña

-- 2. COLORES NEÓN PARA LOS TÍTULOS (PESTAÑAS)
config.colors = {
	tab_bar = {
		-- Fondo transparente para que no parezca una "barra", solo pestañas flotando
		background = "rgba(0, 0, 0, 0)",

		-- Pestaña activa en Cian eléctrico
		active_tab = {
			bg_color = "#00f0ff",
			fg_color = "#0b0814",
			intensity = "Bold",
		},

		-- Pestañas en segundo plano en Rosa/Morado oscuro
		inactive_tab = {
			bg_color = "#1a0b1c",
			fg_color = "#ff003c",
		},

		-- Color al pasar el ratón por encima
		inactive_tab_hover = {
			bg_color = "#ff003c",
			fg_color = "#0b0814",
		},
	},
}

-- 3. CORRECCIÓN DEL FONDO (El error de los comandos)
config.background = {
	{
		source = { Color = "#000000" },
		opacity = 0.66,
	},
	{
		source = { File = wezterm.config_dir .. "/neon_frame.png" },
		horizontal_align = "Center",
		vertical_align = "Middle",
		repeat_x = "NoRepeat",
		repeat_y = "NoRepeat",
		-- Aquí está la corrección de sintaxis
		width = "100%",
		height = "100%",
		opacity = 0.66,
	},
}

config.window_padding = { left = 30, right = 30, top = 30, bottom = 30 }
config.initial_cols = 110
config.initial_rows = 30

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	gui_window:maximize()
end)

return config
