return {
  "nomnivore/ollama.nvim",

  -- Dependencias que necesita el plugin
  dependencies = { "nvim-lua/plenary.nvim" },

  -- Comandos que el plugin hará disponibles
  cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

  -- Configuración principal
  opts = {
    -- El modelo que usará por defecto.
    -- ¡He puesto el que ya tienes descargado!
    model = "codegemma:7b",

    -- Esto es para que nvim inicie 'ollama serve'
    -- automáticamente por ti cuando abras el editor.
    serve = {
      on_start = true,
      command = "ollama",
      args = { "serve" },
      stop_command = "pkill",
      stop_args = { "-SIGTERM", "ollama" },
    },
  },
}
