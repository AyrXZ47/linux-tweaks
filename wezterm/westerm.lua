-- Importar la librería de wezterm
local wezterm = require("wezterm")

-- Esta es la tabla donde va toda la configuración
local config = {}

-- [[ TEMA Y COLORES ]]
-- ¡Aquí está la magia! Vamos a poner "Tokyo Night",
-- el mismo tema que te gustó para LazyVim.
config.color_scheme = "Cyberdyne"

-- [[ FUENTES ]]
-- Esto es CLAVE para que los íconos de p10k y Neovim se vean bien.
-- Asegúrate de tener "JetBrains Mono Nerd Font" instalada (ver Paso 3).
config.font = wezterm.font("JetBrains Mono Nerd Font")
config.font_size = 16.0

-- [[ APARIENCIA Y "CHROME" ]]
-- Esto es lo que funciona CON "Blur My Shell".
-- "Blur My Shell" difumina lo que está DETRÁS de la ventana.
-- Esta línea hace que WezTerm sea TRANSPARENTE.
-- El resultado: Una terminal transparente flotando sobre un fondo borroso.
config.window_background_opacity = 0.66

-- Un poco de espacio para que el texto no se pegue a los bordes
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

-- ¡Devolvemos la configuración para que WezTerm la aplique!
return config
