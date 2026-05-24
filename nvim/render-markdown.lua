return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"echasnovski/mini.nvim",
	},
	opts = {
		heading = {
			-- Íconos progresivos para los niveles de los títulos
			icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			sign = true,
			position = "inline",
		},
		code = {
			-- Hace que los bloques de código ocupen todo el ancho disponible
			sign = true,
			width = "block",
			right_pad = 1,
		},
		bullet = {
			-- Viñetas elegantes para las listas
			icons = { "●", "○", "◆", "◇" },
		},
		checkbox = {
			-- Cajas de tareas con estilo
			unchecked = { icon = "󰄱 " },
			checked = { icon = "󰱒 " },
		},
	},
}
