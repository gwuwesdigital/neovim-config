-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	-- Package manager
	use("wbthomason/packer.nvim")

	-- LSP Configuration & Plugins
	use({
		"neovim/nvim-lspconfig",
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- Useful status updates for LSP
			"j-hui/fidget.nvim",
			-- Additional lua configuration, makes nvim stuff amazing
			"folke/neodev.nvim",
			-- Formatting and Diagnostics
			"jose-elias-alvarez/null-ls.nvim",
		},
	})
	use("RRethy/vim-illuminate") -- highlight cursor word

	-- Autocompletion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
	})

	-- Snippets
	use({ "L3MON4D3/LuaSnip" }) --snippet engine
	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

	-- Highlight, edit, and navigate code
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})
	-- Additional text objects via treesitter
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})


	-- Git related plugins
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("lewis6991/gitsigns.nvim")

	-- Colorscheme
	use("folke/tokyonight.nvim")

    -- Navigation
	-- 1. Telescope
	--    Fuzzy Finder (files, lsp, etc)
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-live-grep-args.nvim" },
	})
	--    Fuzzy Finder Algorithm which requires local dependencies to be built
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    -- 2. Whichkey
	use("folke/which-key.nvim") -- Keymap hinter
    -- 3. Harpoon
	use("theprimeagen/harpoon") -- Quick navigation between buffers
    -- 4. File tree
    use("kyazdani42/nvim-tree.lua")
    use({ "nvim-tree/nvim-web-devicons" })

    -- Other useful plugins
	use("christoomey/vim-tmux-navigator") -- Tmux Vim negvigator
	use("mbbill/undotree") -- Undo tree
	use("nvim-lualine/lualine.nvim") -- Fancier statusline
	use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines
	use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
	-- use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically
	use("tpope/vim-obsession") -- Session manager
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	if is_bootstrap then
		require("packer").sync()
	end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

-- Automatically source and re-compile packer whenever you save this lua/user/plugins.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerSync",
	group = packer_group,
	pattern = vim.fn.expand("$HOME/.config/nvim/lua/user/plugins.lua"),
})
