local _general_settings = vim.api.nvim_create_augroup("GeneralSettings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	command = "nnoremap <silent> <buffer> q :close<CR>",
	group = _general_settings,
	pattern = { "qf", "help", "man", "lspinfo" },
})
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
	group = _general_settings,
	pattern = "*",
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	command = "set formatoptions-=cro",
	group = _general_settings,
	pattern = "*",
})
vim.api.nvim_create_autocmd("FileType", {
	command = "set nobuflisted",
	group = _general_settings,
	pattern = "qf",
})

local _git = vim.api.nvim_create_augroup("Git", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	command = "setlocal wrap",
	group = _git,
	pattern = { "gitcommit" },
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	command = "setlocal spell",
	group = _git,
	pattern = { "gitcommit" },
})

local _markdown = vim.api.nvim_create_augroup("Git", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	command = "setlocal wrap",
	group = _markdown,
	pattern = { "markdown" },
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	command = "setlocal spell",
	group = _markdown,
	pattern = { "markdown" },
})

local _auto_resize = vim.api.nvim_create_augroup("AutoResize", { clear = true })
vim.api.nvim_create_autocmd({ "VimResized" }, {
	command = "tabdo wincmd =",
	group = _auto_resize,
	pattern = { "*" },
})

local _auto_reload = vim.api.nvim_create_augroup("AutoReload", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	group = _auto_reload,
	pattern = { "*" },
})
