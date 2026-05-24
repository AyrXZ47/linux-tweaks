return {
	"HakonHarnes/img-clip.nvim",
	event = "VeryLazy",
	opts = {
		default = {
			dir_path = "assets", -- Carpeta donde se guardarán (se crea automáticamente)
			extension = "png",
			prompt_for_file_name = false, -- Auto-genera un nombre basado en la fecha/hora
			drag_and_drop = {
				insert_mode = true,
			},
		},
	},
	keys = {
		-- Presiona tu tecla líder (usualmente espacio) + p para pegar la imagen
		{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Pegar imagen desde el portapapeles" },
	},
}
