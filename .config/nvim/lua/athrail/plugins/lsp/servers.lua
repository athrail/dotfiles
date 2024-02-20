Servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  tsserver = {},
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  cmake = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

return {}
