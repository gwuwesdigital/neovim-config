local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")
local lga_actions = require("telescope-live-grep-args.actions")

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
telescope.setup({
	defaults = {

		layout_strategy = "vertical",

		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { shorten = { len = 5, exclude = { -1, -2, -3 } } },

		file_ignore_patterns = { "^.git/", "secret", "Session.vim" },

		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,

				["<CR>"] = actions.select_default,
				["<C-e>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.smart_send_to_loclist + actions.open_loclist,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["?"] = actions.which_key, -- keys from pressing <C-/>
			},
			n = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-e>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.smart_send_to_loclist + actions.open_loclist,

				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,

				-- ["<Down>"] = actions.move_selection_next,
				-- ["<Up>"] = actions.move_selection_previous,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["?"] = actions.which_key,
			},
		},
	},
	pickers = { -- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
		buffers = {
			prompt_title = "\\Most Recent Buffers/",
			theme = "dropdown",
			previewer = false,
			ignore_current_buffer = true,
			sort_mru = true,
		},
		current_buffer_fuzzy_find = {
			prompt_title = "\\Search in Current Buffer/",
		},
		find_files = {
			prompt_title = "\\Workspace Files/",
			hidden = true,
			no_ignore = true,
			follow = true,
		},
		git_files = {
			prompt_title = "\\Git Files/",
		},
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
		-- fzf = {
		-- 	fuzzy = true, -- false will only do exact matching
		-- 	override_generic_sorter = true, -- override the generic sorter
		-- 	override_file_sorter = true, -- override the file sorter
		-- 	case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		-- the default case_mode is "smart_case"
		-- },
		live_grep_args = {
			prompt_title = "\\Search in Current Workspace/",
			theme = "ivy",
			layout_config = { height = 35 },
			vimgrep_arguments = {
				"rg",
				"--hidden",
                "--no-ignore",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			mappings = {
				i = {
					["<C-g>"] = lga_actions.quote_prompt({ postfix = " --iglob" }),
				},
			},
		},
	},
})

-- Enable telescope extensions
pcall(telescope.load_extension, "live_grep_args")
pcall(telescope.load_extension, "fzf")
