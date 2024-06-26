local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = false, -- shows a list of your marks on ' and `
		registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
		},
	},
	window = {
		border = "rounded", -- none, single, double, shadow
	},
	-- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
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
	["/"] = {
		'<cmd>Telescope current_buffer_fuzzy_find theme=ivy layout_config={"height":35}<cr>',
		"Search in Currnt Buffer",
	},
	["f"] = { "<cmd>Telescope live_grep_args<cr>", "Search in Current Workspace" },
	["*"] = {
		"<cmd>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<cr>",
		"Search in Current Workspace",
	},
	["n"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["r"] = { "<cmd>Telescope buffers<cr>", "Most Recent Buffers" },
	["w"] = { "<cmd>w!<CR>", "Save File" },
	["W"] = { "<cmd>mksession!<CR>", "Save Session" },
	["x"] = { "<cmd>bdelete<CR>", "Close Buffer" },
	["X"] = { "<cmd>%bd|e#|bd#<CR>", "Close All Buffers" },

	-- Ignore keymaps managed outside of which-key
	["<space>"] = "which_key_ignore",
	["p"] = "which_key_ignore",
	["P"] = "which_key_ignore",
	["y"] = "which_key_ignore",
	["Y"] = "which_key_ignore",

	d = {
		name = "Diff Files",
		o = { "<cmd>windo diffthis<cr>", "Open Diff View" },
		c = { "<cmd>windo diffoff<cr>", "Close Diff View" },
	},

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
		l = { "<cmd>Git log --graph<cr>", "Commit Logs" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>GBrowse<cr>", "Open in Browser" },
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
		h = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Explorer" },
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
		n = { "<cmd>NullLsInfo<cr>", "NullLs" },
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
        a = { "<cmd>lua require('defaults').save_and_quit('all')<CR>", "Current All" },
		o = { "<C-w><C-o>", "Others" },
        q = { "<cmd>lua require('defaults').save_and_quit('single')<CR>", "Current Window" },
	},

	s = {
		name = "Search",
		c = { "<cmd>Telescope commands<cr>", "Commands" },
		f = { "<cmd>Telescope find_files<cr>", "Workspace Files" },
		F = { "<cmd>lua require('telescope.extra').project_files()<cr>", "Project Files" },
		h = { "<cmd>Telescope help_tags<cr>", "Help" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		s = { "<cmd>Telescope resume<cr>", "Resume Last Search" },
		R = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace Current Word", silent = false },
		["'"] = { "<cmd>Telescope registers<cr>", "Registers" },
	},

	t = {
		name = "Troubleshoot",
		d = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Add Diagnostic to Quickfix" },
		l = {
			name = "Location List",
			j = { "<cmd>lnext<cr>", "Goto Next" },
			k = { "<cmd>lprev<cr>", "Goto Prev" },
			l = { "<cmd>lopen<cr>", "Open Location List" },
			s = { "<cmd>Telescope loclist<cr>", "Search Location List" },
		},
		q = {
			name = "Quickfix List",
			j = { "<cmd>cnext<cr>", "Goto Next" },
			k = { "<cmd>cprev<cr>", "Goto Prev" },
			q = { "<cmd>copen<cr>", "Open Quickfix List" },
			s = { "<cmd>Telescope quickfix<cr>", "Search Quickfix List" },
		},
		u = { "<cmd>UndotreeToggle<CR>", "UndoTree" },
	},
}

which_key.setup(setup)
which_key.register(mappings, opts)
