return {
  "epwalsh/obsidian.nvim",
  version = "*", -- Usa la última versión estable
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Sync/Notes",
      },
    },

    -- Formato automático de los enlaces para que se vean limpios
    wiki_link_func = function(opts)
      return require("obsidian.util").wiki_link_id_prefix(opts)
    end,
  },
}
