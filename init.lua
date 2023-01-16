require("user.autocommands")
require("user.cmp")
require("user.colorscheme")
require("user.comment")
require("user.gitsigns")
require("user.indentline")
require("user.keymaps")
require("user.lsp")
require("user.lualine")
require("user.nvimtree")
require("user.options")
require("user.plugins")
require("user.telescope")
require("user.treesitter")
require("user.variables")
require("user.whichkey")

-- Allow require to look in after/plugin folder
local home_dir = os.getenv("HOME")
package.path = home_dir .. "/.config/nvim/after/plugin/?.lua;" .. package.path

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
