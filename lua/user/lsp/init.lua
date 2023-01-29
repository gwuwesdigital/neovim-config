-- Setup neovim lua configuration
require("neodev").setup()

require("user.lsp.mason")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")

-- Turn on lsp status information
require("fidget").setup()
