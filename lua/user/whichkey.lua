local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = false, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	-- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
	disable = {
		filetypes = { "fugitive" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["f"] = {
		'<cmd>Telescope current_buffer_fuzzy_find theme=ivy layout_config={"height":35}<cr>',
		"Search in Currnt Buffer",
	},
	["F"] = { "<cmd>Telescope live_grep_args<cr>", "Search in Current Workspace" },
	["n"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	-- ["r"] = { "<cmd>%s/<<C-r><C-w>>/<C-r><C-w>/gI<Left><Left><Left><cr>", "Replace" },
	-- ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
	-- ["x"] = { "<cmd>!chmod +x %<cr>", "Make Executable" },
	["r"] = { "<cmd>Telescope buffers<cr>", "Most Recent Buffers" },
	["w"] = { "<cmd>w!<CR>", "Save" },
	["x"] = { "<cmd>bdelete<CR>", "Close Buffer" },
	["X"] = { "<cmd>%bd|e#|bd#<CR>", "Close All Buffers" },

	-- Ignore keymaps managed outside of which-key
	["<space>"] = "which_key_ignore",
	["p"] = "which_key_ignore",
	["P"] = "which_key_ignore",
	["y"] = "which_key_ignore",
	["Y"] = "which_key_ignore",
	["d"] = "which_key_ignore",

	g = {
		name = "Git",
		b = { "<cmd>Git blame<cr>", "Blame" },
		c = { "<cmd>Telescope git_branches<cr>", "Checkout Branch" },
		C = { "<cmd>Telescope git_commits<cr>", "Checkout Commits" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
		g = { "<cmd>Git<cr>", "Git Status" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>Git log --graph<cr>", "Commit Logs" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open Changed File" },
		O = { "<cmd>GBrowse<cr>", "Open in Browser" },
	},

	h = {
		name = "Harpoon",
		["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "which_key_ignore" },
		["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "which_key_ignore" },
		["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "which_key_ignore" },
		["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "which_key_ignore" },
		["5"] = { "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", "which_key_ignore" },
		["6"] = { "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", "which_key_ignore" },
		["7"] = { "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", "which_key_ignore" },
		["8"] = { "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", "which_key_ignore" },
		["9"] = { "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", "which_key_ignore" },
		a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add File" },
		e = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Explorer" },
		n = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Next" },
		p = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Prev" },
	},

	l = {
		name = "LSP",
		d = {
			"<cmd>Telescope diagnostics bufnr=0<cr>",
			"Document Diagnostics",
		},
		D = {
			"<cmd>Telescope diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		j = {
			"<cmd>lua vim.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		m = { "<cmd>Mason<cr>", "Mason" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},

	M = {
		name = "Plugin Manager",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	q = {
		name = "Quit",
		a = { "<cmd>qa<CR>", "Current All" },
		o = { "<C-w><C-o>", "Others" },
		q = { "<cmd>q<CR>", "Current Window" },
	},

	s = {
		name = "Search",
		c = { "<cmd>Telescope commands<cr>", "Commands" },
		f = { "<cmd>lua require('telescope.extra').project_files()<cr>", "Project Files" },
		F = { "<cmd>Telescope find_files<cr>", "Workspace Files" },
		h = { "<cmd>Telescope help_tags<cr>", "Help" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope resume<cr>", "Resume Last Search" },
		R = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace Current Word", silent = false },
		w = { "<cmd>Telescope grep_string<cr>", "Current Word" },
		W = {
			"<cmd>lua require('telescope.builtin').grep_string({additional_args={'--hidden', '--no-ignore'}})<cr>",
			"Current Word (incl. hidden and ignored)",
		},
		["'"] = { "<cmd>Telescope registers<cr>", "Registers" },
	},

	t = {
		name = "Troubleshoot",
		d = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Add Diagnostic to Quickfix" },
        l = {
            name = "Location List",
            f = { "<cmd>lfirst<cr>", "Goto First" },
            l = { "<cmd>llast<cr>", "Goto Last" },
            n = { "<cmd>lnext<cr>", "Goto Next" },
            o = { "<cmd>lopen<cr>", "Open Location List" },
            p = { "<cmd>lprev<cr>", "Goto Prev" },
            s = { "<cmd>Telescope loclist<cr>", "Search Location List" },
        },
		q = {
            name = "Quickfix List",
            f = { "<cmd>cfirst<cr>", "Goto First" },
            l = { "<cmd>clast<cr>", "Goto Last" },
            n = { "<cmd>cnext<cr>", "Goto Next" },
            o = { "<cmd>copen<cr>", "Open Quickfix List" },
            p = { "<cmd>cprev<cr>", "Goto Prev" },
            s = { "<cmd>Telescope quickfix<cr>", "Search Quickfix List" },

        },
		u = { "<cmd>UndotreeToggle<CR>", "UndoTree" },
	},
}

which_key.setup(setup)
which_key.register(mappings, opts)
