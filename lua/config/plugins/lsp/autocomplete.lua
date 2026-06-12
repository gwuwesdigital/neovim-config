return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"saghen/blink.cmp",
		event = "VimEnter",
		dependencies = {
			"saghen/blink.lib",
			"L3MON4D3/LuaSnip",
		},
		build = function()
			-- build the fuzzy matcher from source
			-- you can use `gb` in `:Lazy` to rebuild the plugin as needed
			require("blink.cmp").build():pwait()
		end,

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			completion = {
				documentation = { auto_show = true },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					lua = { inherit_defaults = true, "lazydev" },
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
			snippets = { preset = "luasnip" },
			fuzzy = { implementation = "prefer_rust_with_warning" },
			signature = { enabled = true },
		},
	},
}
