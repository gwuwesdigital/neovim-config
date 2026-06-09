return {
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			local configs = require("tokyonight")
			configs.setup({
				style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				transparent = true, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
				sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`

				-- -- Change the "hint" color to the "orange" color, and make the "error" color bright red
				-- on_colors = function(colors)
				-- 	colors.comment = "#737aa2" --colors.dark5
				-- 	colors.fg_gutter = "#545c7e" --colors.dark3
				-- 	colors.git = {
				-- 		change = "#86e1fc", --colors.cyan
				-- 		add = "#c3e88d", --colors.green
				-- 		delete = "#ff757f", --colors.red
				-- 	}
				-- end,

				-- on_highlights = function(highlights, c)
				-- 	highlights.CursorLine = {
				-- 		bg = "#444a73", --colors.terminal_black
				-- 	}
				-- 	highlights.CursorLineNr = {
				-- 		fg = "#c8d3f5", --colors.fg
				-- 	}
				-- 	highlights.GitSignsCurrentLineBlame = {
				-- 		fg = "#828bb8", --colors.fg_dark
				-- 	}
				-- 	highlights.DiagnosticUnnecessary = {
				-- 		fg = c.comment, --colors.terminal_black
				-- 	}
				-- end,
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
}
