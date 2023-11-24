local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
	return
end

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
indent_blankline.setup({
	indent = { char = "▏" },
	-- show_first_indent_level = true,
	-- use_treesitter = true,
	-- buftype_exclude = { "terminal", "nofile" },
	exclude = {
		filetypes = {
			"undotree",
		},
	},
})
