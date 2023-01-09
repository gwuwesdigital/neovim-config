local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end


-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
indent_blankline.setup({
  char = '┊',
  show_trailing_blankline_indent = false,
})
