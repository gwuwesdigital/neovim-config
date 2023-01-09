return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
	[vim.fn.stdpath("config") .. "/lua"] = true,
      },
      telemetry = { enable = false },
    },
  }
}
