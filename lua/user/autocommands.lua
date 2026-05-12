-- GeneralSettings
local _general_settings = vim.api.nvim_create_augroup("GeneralSettings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	desc = "Press q to quit from certain filetype",
	command = "nnoremap <silent> <buffer> q :close<CR>",
	group = _general_settings,
	pattern = { "qf", "help", "man", "lspinfo", "git", "fugitiveblame", "fugitive" },
})
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
	group = _general_settings,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "Disable wrapping comment and adding comment leader (#, --, //) when a newline is created",
	command = "set formatoptions-=cro",
	group = _general_settings,
})
vim.api.nvim_create_autocmd("FileType", {
	desc = "Don't should QuickFix list in the buffer",
	command = "set nobuflisted",
	group = _general_settings,
	pattern = "qf",
})

-- Git
local _git = vim.api.nvim_create_augroup("Git", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Automatically wrap git commit message",
	command = "setlocal wrap",
	group = _git,
	pattern = "gitcommit",
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Check spelling mistake in git commit message",
	command = "setlocal spell",
	group = _git,
	pattern = "gitcommit",
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Fugitive specific keymaps",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()

		vim.keymap.set("n", "<leader>f", function()
			vim.cmd.Git("fetch")
		end, { buffer = bufnr, remap = false, desc = "Fetch" })

		vim.keymap.set("n", "<leader>P", function()
			vim.cmd.Git("push")
		end, { buffer = bufnr, remap = false, desc = "Push" })

		vim.keymap.set("n", "<leader>p", function()
			vim.cmd.Git("pull")
		end, { buffer = bufnr, remap = false, desc = "Pull" })

		vim.keymap.set("n", "<leader>b", function()
			vim.cmd.Git("pull --rebase")
		end, { buffer = bufnr, remap = false, desc = "Rebase Pull" })
	end,
	group = _git,
	pattern = "fugitive",
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Avoid word highlight to jump to the next occurrence in Fugitive",
	callback = function(event)
		vim.keymap.set("n", "*", "<cmd>keepjumps normal! mi*`i<cr>", { buffer = event.buf, remap = false })
	end,
	group = _git,
	pattern = { "fugitive", "git" },
})

-- LSP
local _lsp = vim.api.nvim_create_augroup("LSP", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = _lsp,
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "[LSP]: " .. desc })
		end

		-- Common LSP usage and servers information
		map("<leader>lf", function()
			vim.lsp.buf.format({
				filter = function(client)
					return client.name == "null-ls" or client.name == "ruff"
				end,
				timeout_ms = 3000,
			})
		end, "Format")
		map("<leader>li", "<cmd>LspInfo<cr>", "Server Info")
		map("<leader>lm", "<cmd>Mason<cr>", "Mason")
		map("<leader>ln", "<cmd>NullLsInfo<cr>", "NullLs")
		map("<leader>lh", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
		end, "Toggle Inlay Hints")

		-- Conditionally add language specific keymaps:
		-- -- sqls
		-- local client = vim.lsp.get_client_by_id(event.data.client_id)
		-- if client and client.name == "sqls" then
		-- 	map("<leader><cr>", "<Plug>(sqls-execute-query)", "Execute SQL", { "n", "v" })
		-- end

		-- Navigate between diagnostics
		map("<leader>lj", "<cmd>lua vim.diagnostic.jump({ count = 1, float = true })<cr>", "Goto Next Diagnostic")
		map("<leader>lk", "<cmd>lua vim.diagnostic.jump({ count = -1, float = true })<cr>", "Goto Prev Diagnostic")

		-- Open diagnostics in a floatting window
		map("gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "[L]ine Diagnostics")

		-- Rename the variable under your cursor.
		--  Most Language Servers support renaming across files, etc.
		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

		-- Execute a code action, usually your cursor needs to be on top of an error
		-- or a suggestion from your LSP for this to activate.
		map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

		-- Find references for the word under your cursor.
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

		-- Jump to the implementation of the word under your cursor.
		--  Useful when your language has ways of declaring types without an actual implementation.
		map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

		-- Jump to the definition of the word under your cursor.
		--  This is where a variable was first declared, or where a function is defined, etc.
		--  To jump back, press <C-t>.
		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

		-- WARN: This is not Goto Definition, this is Goto Declaration.
		--  For example, in C this would take you to the header.
		map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- Fuzzy find all the symbols in your current document.
		--  Symbols are things like variables, functions, types, etc.
		map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

		-- Fuzzy find all the symbols in your current workspace.
		--  Similar to document symbols, except searches over your entire project.
		map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

		-- Jump to the type of the word under your cursor.
		--  Useful when you're not sure what type a variable is and you want to see
		--  the definition of its *type*, not where it was *defined*.
		map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
	end,
})

-- Markdown
local _markdown = vim.api.nvim_create_augroup("Markdown", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Enable text wrapping in markdown files",
	command = "setlocal wrap",
	group = _markdown,
	pattern = "markdown",
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Enable linebreak in markdown files",
	command = "setlocal linebreak",
	group = _markdown,
	pattern = "markdown",
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Enable spelling checks in markdown files",
	command = "setlocal spell",
	group = _markdown,
	pattern = "markdown",
})

-- Treesitter
local _treesitter = vim.api.nvim_create_augroup("Treesitter", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable treesitter highlighting, disabled on large files (>500KB)",
	callback = function(args)
		local max_filesize = 500 * 1024 -- 500 KB
		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
		if ok and stats and stats.size > max_filesize then
			return
		end
		pcall(vim.treesitter.start)
	end,
	group = _treesitter,
})
vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable treesitter-based indentation",
	callback = function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
	group = _treesitter,
})
vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable treesitter-based folds",
	callback = function()
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"
	end,
	group = _treesitter,
})

-- Display
local _auto_resize = vim.api.nvim_create_augroup("AutoResize", { clear = true })
vim.api.nvim_create_autocmd({ "VimResized" }, {
	desc = "Equalise buffer window when the Vim window size changes",
	command = "tabdo wincmd =",
	group = _auto_resize,
})
local _auto_reload = vim.api.nvim_create_augroup("AutoReload", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	desc = "Automatically checks for external file changes and reloads",
	command = "if mode() != 'c' | checktime | endif",
	group = _auto_reload,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Automatically update git status shown in fugitive",
	command = "call fugitive#ReloadStatus()",
	group = _auto_reload,
	pattern = "fugitive",
})
