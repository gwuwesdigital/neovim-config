return {
	-- Navigation
	"christoomey/vim-tmux-navigator",
	"easymotion/vim-easymotion",
	"theprimeagen/harpoon",
	-- Efficiency
	"tpope/vim-surround",
	"tpope/vim-sleuth",
	"mbbill/undotree",
	-- Visual Aid
	{ "norcalli/nvim-colorizer.lua", opts = {} },
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	"mechatroner/rainbow_csv",
}
