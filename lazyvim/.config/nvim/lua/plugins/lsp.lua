return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
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
        ty = {
          cmd = { "ty", "server" },
          filetypes = { "python", "py" },
          root_markers = { "pyproject.toml" },
        },
        pyright = {
          enabled = false,
        },
      },
    },
  },
}
