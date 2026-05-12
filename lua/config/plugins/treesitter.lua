return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false, -- must NOT be lazy-loaded
		build = ":TSUpdate",
		config = function()
			-- Minimal setup (defaults are fine, no need to call setup unless customizing install_dir)
			require("nvim-treesitter").setup()

			-- Install parsers (replaces ensure_installed)
			require("nvim-treesitter").install({
				"bash",
				"c",
				"cpp",
				"dockerfile",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"javascript",
				"typescript",
				"toml",
				"terraform",
				"sql",
				"yaml",
				"vim",
			})
		end,
	},

	-- textobjects plugin — check its repo for updated setup instructions
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		init = function()
			vim.g.no_plugin_maps = true -- avoid conflicts with built-in ftplugin mappings
		end,
		config = function()
			local textobjects = require("nvim-treesitter-textobjects")

			-- Setup (replaces the old config table options)
			textobjects.setup({
				select = {
					lookahead = true,
					include_surrounding_whitespace = false,
				},
				move = {
					set_jumps = true,
				},
			})

			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")

			-- ── Select keymaps ──────────────────────────────────────────────
			local select_maps = {
				["a="] = { "@assignment.outer", "Select outer part of an assignment" },
				["i="] = { "@assignment.inner", "Select inner part of an assignment" },
				["aa"] = { "@parameter.outer", "Select outer part of a parameter/argument" },
				["ia"] = { "@parameter.inner", "Select inner part of a parameter/argument" },
				["ai"] = { "@conditional.outer", "Select outer part of a conditional" },
				["ii"] = { "@conditional.inner", "Select inner part of a conditional" },
				["al"] = { "@loop.outer", "Select outer part of a loop" },
				["il"] = { "@loop.inner", "Select inner part of a loop" },
				["af"] = { "@call.outer", "Select outer part of a function call" },
				["if"] = { "@call.inner", "Select inner part of a function call" },
				["am"] = { "@function.outer", "Select outer part of a method/function definition" },
				["im"] = { "@function.inner", "Select inner part of a method/function definition" },
				["ac"] = { "@class.outer", "Select outer part of a class" },
				["ic"] = { "@class.inner", "Select inner part of a class" },
			}

			for key, val in pairs(select_maps) do
				vim.keymap.set({ "x", "o" }, key, function()
					select.select_textobject(val[1], "textobjects")
				end, { desc = val[2] })
			end

			-- ── Move keymaps: goto_next_start ───────────────────────────────
			local next_start = {
				["]f"] = { "@call.outer", "Next function call start" },
				["]m"] = { "@function.outer", "Next method/function def start" },
				["]c"] = { "@class.outer", "Next class start" },
				["]i"] = { "@conditional.outer", "Next conditional start" },
				["]l"] = { "@loop.outer", "Next loop start" },
				["]]"] = { "@local.scope", "Next scope", group = "locals" },
				["[]"] = { "@fold", "Next fold", group = "folds" },
			}

			for key, val in pairs(next_start) do
				vim.keymap.set({ "n", "x", "o" }, key, function()
					move.goto_next_start(val[1], val.group or "textobjects")
				end, { desc = val[2] })
			end

			-- ── Move keymaps: goto_next_end ─────────────────────────────────
			local next_end = {
				["]F"] = { "@call.outer", "Next function call end" },
				["]M"] = { "@function.outer", "Next method/function def end" },
				["]C"] = { "@class.outer", "Next class end" },
				["]I"] = { "@conditional.outer", "Next conditional end" },
				["]L"] = { "@loop.outer", "Next loop end" },
			}

			for key, val in pairs(next_end) do
				vim.keymap.set({ "n", "x", "o" }, key, function()
					move.goto_next_end(val[1], "textobjects")
				end, { desc = val[2] })
			end

			-- ── Move keymaps: goto_previous_start ───────────────────────────
			local prev_start = {
				["[f"] = { "@call.outer", "Prev function call start" },
				["[m"] = { "@function.outer", "Prev method/function def start" },
				["[c"] = { "@class.outer", "Prev class start" },
				["[i"] = { "@conditional.outer", "Prev conditional start" },
				["[l"] = { "@loop.outer", "Prev loop start" },
			}

			for key, val in pairs(prev_start) do
				vim.keymap.set({ "n", "x", "o" }, key, function()
					move.goto_previous_start(val[1], "textobjects")
				end, { desc = val[2] })
			end

			-- ── Move keymaps: goto_previous_end ─────────────────────────────
			local prev_end = {
				["[F"] = { "@call.outer", "Prev function call end" },
				["[M"] = { "@function.outer", "Prev method/function def end" },
				["[C"] = { "@class.outer", "Prev class end" },
				["[I"] = { "@conditional.outer", "Prev conditional end" },
				["[L"] = { "@loop.outer", "Prev loop end" },
			}

			for key, val in pairs(prev_end) do
				vim.keymap.set({ "n", "x", "o" }, key, function()
					move.goto_previous_end(val[1], "textobjects")
				end, { desc = val[2] })
			end
		end,
	},
}
