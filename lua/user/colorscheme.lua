local status_ok, tokyonight = pcall(require, "tokyonight")
if not status_ok then
	return
end

tokyonight.setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	transparent = true, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "dark", -- style for sidebars, see below
		floats = "dark", -- style for floating windows
	},
	sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false, -- dims inactive windows
	lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    on_colors = function(colors)
        colors.comment = "#737aa2"          --colors.dark5
        colors.terminal_black = "#828bb8"   --colors.fg_dark
        colors.fg_gutter = "#545c7e"        --colors.dark3
        colors.git = {
            change = "#86e1fc",             --colors.cyan
            add = "#c3e88d",                --colors.green
            delete = "#ff757f",             --colors.red
        }
        colors.gitSigns = {
            change = "#86e1fc",             --colors.cyan
            add = "#c3e88d",                --colors.green
            delete = "#ff757f",             --colors.red
        }
    end,

    on_highlights = function(highlights, _)
        highlights.CursorLine = {
            bg = "#444a73", --colors.terminal_black
        }
        highlights.CursorLineNr = {
            fg = "#c8d3f5", --colors.fg
        }
        highlights.GitSignsCurrentLineBlame = {
            fg = "#828bb8", --colors.fg_dark
        }
    end,
})

-- Set colorscheme
vim.cmd([[ colorscheme tokyonight ]])
