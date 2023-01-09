-- Set completeopt to have a better completion experience
local options = {
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines

	tabstop = 4, -- insert 2 spaces for a tab
	softtabstop = 4,
	shiftwidth = 4, -- the number of spaces inserted for each indentation
	expandtab = true, -- convert tabs to spaces

	smartindent = true, -- make indenting smarter again

	wrap = false,
	-- whichwrap = "bs<>[]hl", -- which "horizontal" keys are allowed to travel to prev/next line

	swapfile = false, -- creates a swapfile
	backup = false, -- creates a backup file
	undodir = os.getenv("HOME") .. "/.local/share/nvim/shada/undodir",
	undofile = true, -- enable persistent undo

	hlsearch = true, -- highlight all matches on previous search pattern
	incsearch = true,

	termguicolors = true,

	scrolloff = 8,
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	updatetime = 50, -- faster completion (4000ms default)

	cursorline = true, -- highlight the current line
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	mouse = "a", -- allow the mouse to be used in neovim
	breakindent = true,
	ignorecase = true, -- ignore case in search patterns
	smartcase = true, -- smart case
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp

	autoread = true,

	-- conceallevel = 0,                        -- so that `` is visible in markdown files
	-- fileencoding = "utf-8",                  -- the encoding written to a file
	-- pumheight = 10,                          -- pop up menu height
	-- showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
	-- showtabline = 2,                         -- always show tabs
	-- splitbelow = true,                       -- force all horizontal splits to go below current window
	-- splitright = true,                       -- force all vertical splits to go to the right of current window
	-- timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
	-- writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	-- numberwidth = 4,                         -- set number column width to 2 {default 4}
	-- linebreak = true, -- companion to wrap, don't split words
	-- sidescrolloff = 8, -- minimal number of screen columns either side of cursor if wrap is `false`
	-- guifont = "monospace:h17",               -- the font used in graphical neovim applications
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.isfname:append("@-@")

-- -- vim.opt.shortmess = "ilmnrx"                        -- flags to shorten vim messages, see :help 'shortmess'
-- vim.opt.shortmess:append "c"                           -- don't give |ins-completion-menu| messages
-- vim.opt.iskeyword:append "-"                           -- hyphenated words recognized by searches
-- vim.opt.formatoptions:remove({ "c", "r", "o" })        -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
-- vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")  -- separate vim plugins from neovim in case vim still in use
