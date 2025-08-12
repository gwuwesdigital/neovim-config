return {
	-- show lsp status on load
	{ "j-hui/fidget.nvim", opts = {} },
	-- highlight other uses of the word under the cursor
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				filetypes_denylist = {
					"dirbuf",
					"dirvish",
					"fugitive",
					"NvimTree",
				},
				large_file_cutoff = 5000,
			})
		end,
	},
}
