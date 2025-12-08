return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          settings = {
            tailwindCSS = {
              includeLanguages = {
                htmldjango = "html",
              },
            },
          },
        },
      },
    },
  },
}
