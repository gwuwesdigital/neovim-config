return {
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			local nvim_tree = require("nvim-tree")

			local function on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default keybinds
				api.config.mappings.default_on_attach(bufnr)

				-- remove keymaps
				vim.keymap.set("n", "<C-k>", "", { buffer = bufnr })
				vim.keymap.del("n", "<C-k>", { buffer = bufnr })
				vim.keymap.set("n", "<C-x>", "", { buffer = bufnr })
				vim.keymap.del("n", "<C-x>", { buffer = bufnr })
				vim.keymap.del("n", "<C-t>", { buffer = bufnr })
				vim.keymap.set("n", "<C-t>", "", { buffer = bufnr })
				vim.keymap.set("n", "o", "", { buffer = bufnr })
				vim.keymap.del("n", "o", { buffer = bufnr })
				vim.keymap.set("n", "O", "", { buffer = bufnr })
				vim.keymap.del("n", "O", { buffer = bufnr })
				vim.keymap.set("n", "[c", "", { buffer = bufnr })
				vim.keymap.del("n", "[c", { buffer = bufnr })
				vim.keymap.set("n", "]c", "", { buffer = bufnr })
				vim.keymap.del("n", "]c", { buffer = bufnr })
				vim.keymap.set("n", "[e", "", { buffer = bufnr })
				vim.keymap.del("n", "[e", { buffer = bufnr })
				vim.keymap.set("n", "]e", "", { buffer = bufnr })
				vim.keymap.del("n", "]e", { buffer = bufnr })
				vim.keymap.set("n", ">", "", { buffer = bufnr })
				vim.keymap.del("n", ">", { buffer = bufnr })
				vim.keymap.set("n", "<", "", { buffer = bufnr })
				vim.keymap.del("n", "<", { buffer = bufnr })
				vim.keymap.set("n", "]c", "", { buffer = bufnr })
				vim.keymap.del("n", "]c", { buffer = bufnr })

				-- custom keymaps
				vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
				vim.keymap.set("n", "<C-e>", api.node.open.horizontal, opts("Open: Horizontal Split"))
				vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
				vim.keymap.set("n", "<C-p>", api.node.show_info_popup, opts("Info"))
				vim.keymap.set("n", "(", api.node.navigate.git.prev, opts("Prev Git"))
				vim.keymap.set("n", ")", api.node.navigate.git.next, opts("Next Git"))
				vim.keymap.set("n", "{", api.node.navigate.sibling.prev, opts("Prev Sibling"))
				vim.keymap.set("n", "}", api.node.navigate.sibling.next, opts("Next Sibling"))
			end

			nvim_tree.setup({
				on_attach = on_attach,
				update_focused_file = {
					enable = true,
				},
				renderer = {
					root_folder_modifier = ":t",
					icons = {
						glyphs = {
							git = {
								unstaged = "",
								staged = "+",
								renamed = "»",
								untracked = "?",
								deleted = "✘",
							},
						},
					},
				},
				diagnostics = {
					enable = true,
					show_on_dirs = true,
				},
				view = { width = 35 },
			})
		end,
	},
}
