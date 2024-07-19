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
	delay = 400,
	icons = {
		mappings = false,
	},
	triggers = {
		{ "<leader>", mode = { "n", "v" } },
	},
	-- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	disable = {
		ft = { "fugitive" },
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
	{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
	{
		"<leader>/",
		'<cmd>Telescope current_buffer_fuzzy_find theme=ivy layout_config={"height":35}<cr>',
		desc = "Search in Currnt Buffer",
	},
	{ "<leader>f", "<cmd>Telescope live_grep_args<cr>", desc = "Search in Current Workspace" },
	{
		"<leader>*",
		"<cmd>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<cr>",
		desc = "Search in Current Workspace",
	},
	{ "<leader>n", "<cmd>nohlsearch<CR>", desc = "No Highlight" },
	{ "<leader>r", "<cmd>Telescope buffers<cr>", desc = "Most Recent Buffers" },
	{ "<leader>w", "<cmd>w!<CR>", desc = "Save File" },
	{ "<leader>W", "<cmd>mksession!<CR>", desc = "Save Session" },
	{ "<leader>x", "<cmd>bdelete<CR>", desc = "Close Buffer" },
	{ "<leader>X", "<cmd>%bd|e#|bd#<CR>", desc = "Close All Buffers" },

	-- Ignore keymaps managed outside of which-key
	{ "<leader>y", hidden = true },
	{ "<leader>Y", hidden = true },
	{ "<leader><space>", desc = "EasyMotion" },

	{
		"<leader>d",
		group = "Diff Files",
		{ "<leader>do", "<cmd>windo diffthis<cr>", desc = "Open Diff View" },
		{ "<leader>dc", "<cmd>windo diffoff<cr>", desc = "Close Diff View" },
	},

	{
		"<leader>g",
		group = "Git",
		{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Blame" },
		{ "<leader>gc", "<cmd>Telescope git_branches<cr>", desc = "Checkout Branch" },
		{ "<leader>gC", "<cmd>Telescope git_commits<cr>", desc = "Checkout Commits" },
		{ "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff" },
		{ "<leader>gg", "<cmd>Git<cr>", desc = "Git Status" },
		{ "<leader>gl", "<cmd>Git log --graph<cr>", desc = "Commit Logs" },
		{ "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk" },
		{ "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk" },
		{ "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
		{ "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk" },
		{ "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },
		{ "<leader>go", "<cmd>GBrowse<cr>", desc = "Open in Browser" },
	},

	{
		"<leader>h",
		group = "Harpoon",
		{ "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "which_key_ignore" },
		{ "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "which_key_ignore" },
		{ "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "which_key_ignore" },
		{ "<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "which_key_ignore" },
		{ "<leader>h5", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", desc = "which_key_ignore" },
		{ "<leader>h6", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", desc = "which_key_ignore" },
		{ "<leader>h7", "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", desc = "which_key_ignore" },
		{ "<leader>h8", "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", desc = "which_key_ignore" },
		{ "<leader>h9", "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", desc = "which_key_ignore" },
		{ "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add File" },
		{ "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Explorer" },
		{ "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Next" },
		{ "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Prev" },
	},

	{
		"<leader>l",
		group = "LSP",
		{ "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
		{ "<leader>lD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
		{ "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", desc = "Format" },
		{ "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
		{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
		{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
		{ "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },
		{ "<leader>ln", "<cmd>NullLsInfo<cr>", desc = "NullLs" },
		{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
		{ "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
		{ "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
	},

	{
		"<leader>M",
		group = "Plugin Manager",
		{ "<leader>Mc", "<cmd>PackerCompile<cr>", desc = "Compile" },
		{ "<leader>Mi", "<cmd>PackerInstall<cr>", desc = "Install" },
		{ "<leader>Ms", "<cmd>PackerSync<cr>", desc = "Sync" },
		{ "<leader>MS", "<cmd>PackerStatus<cr>", desc = "Status" },
		{ "<leader>Mu", "<cmd>PackerUpdate<cr>", desc = "Update" },
	},

	{
		"<leader>q",
		group = "Quit",
		{ "<leader>qa", "<cmd>lua require('defaults').save_and_quit('all')<CR>", desc = "Current All" },
		{ "<leader>qo", "<C-w><C-o>", desc = "Others" },
		{ "<leader>qq", "<cmd>lua require('defaults').save_and_quit('single')<CR>", desc = "Current Window" },
	},

	{
		"<leader>s",
		group = "Search",
		{ "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
		{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Workspace Files" },
		{ "<leader>sF", "<cmd>lua require('telescope.extra').project_files()<cr>", desc = "Project Files" },
		{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
		{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
		{ "<leader>sm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
		{ "<leader>ss", "<cmd>Telescope resume<cr>", desc = "Resume Last Search" },
		{
			"<leader>sR",
			[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
			desc = "Replace Current Wordd",
			silent = false,
		},
		{ "<leader>s'", "<cmd>sTelescope registers<cr>", desc = "Registers" },
	},

	{
		"<leader>t",
		group = "Troubleshoot",
		{ "<leader>td", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Add Diagnostic to Quickfix" },
		{
			"<leader>tl",
			group = "Location List",
			{ "<leader>tlj", "<cmd>lnext<cr>", desc = "Goto Next" },
			{ "<leader>tlk", "<cmd>lprev<cr>", desc = "Goto Prev" },
			{ "<leader>tll", "<cmd>lopen<cr>", desc = "Open Location List" },
			{ "<leader>tls", "<cmd>Telescope loclist<cr>", desc = "Search Location List" },
		},
		{
			"<leader>tq",
			group = "Quickfix List",
			{ "<leader>tqj", "<cmd>cnext<cr>", desc = "Goto Next" },
			{ "<leader>tqk", "<cmd>cprev<cr>", desc = "Goto Prev" },
			{ "<leader>tqq", "<cmd>copen<cr>", desc = "Open Quickfix List" },
			{ "<leader>tqs", "<cmd>Telescope quickfix<cr>", desc = "Search Quickfix List" },
		},
		{ "<leader>tu", "<cmd>UndotreeToggle<CR>", desc = "UndoTree" },
	},
}

which_key.setup(setup)
which_key.add(mappings)
