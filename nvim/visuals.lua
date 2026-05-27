return {
	-- Rainbow Delimiters (Paréntesis de colores)
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "BufReadPost",
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},

	-- Treesitter Context (El HUD que se queda pegado arriba)
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		opts = {
			enable = true,
			max_lines = 3, -- Máximo de líneas de contexto a mostrar
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 20, -- Máximas líneas que puede abarcar un solo contexto
			trim_scope = "outer",
			mode = "cursor",
			separator = nil,
			zindex = 20,
		},
	},

	-- LSP Lines (Diagnósticos holográficos en forma de árbol)
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = "LspAttach",
		config = function()
			require("lsp_lines").setup()

			-- Desactivar el texto virtual por defecto para que no choque con las líneas holográficas
			vim.diagnostic.config({
				virtual_text = false,
				virtual_lines = true,
			})

			-- Opcional: Atajo para encender/apagar lsp_lines rápido con <leader>ul
			vim.keymap.set("", "<leader>ul", function()
				local config = vim.diagnostic.config() or {}
				if config.virtual_text then
					vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
				else
					vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
				end
			end, { desc = "Toggle lsp_lines" })
		end,
	},
}
