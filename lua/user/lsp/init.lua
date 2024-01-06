-- Setup neovim lua configuration
require("neodev").setup()

require("user.lsp.mason")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")
require("user.lsp.illuminate")

-- Turn on lsp status information
require("fidget").setup({})
