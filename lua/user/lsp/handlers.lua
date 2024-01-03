local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}
	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
M.on_attach = function(client, bufnr)
	-- if client.name == "sumneko_lua" then
	-- 	client.server_capabilities.documentFormattingProvider = false
	-- end
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "<LSP>: " .. desc
		end

		vim.api.nvim_buf_set_keymap(bufnr, "n", keys, func, { noremap = true, silent = true, desc = desc })
	end

	nmap("gd", "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto [d]efinition")
	nmap("gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>', "Goto [r]eferences")
	nmap("gI", "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto [I]mplementation")
	nmap("gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "[l]ine Diagnostic")
	nmap("gK", "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Do[K]umentation")
	nmap("gS", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Display [S]ignature Information")
	nmap("gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto [D]eclaration")

	-- Lesser used LSP functionality
	-- nmap("<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "[W]orkspace [A]dd Folder")
	-- nmap("<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "[W]orkspace [R]emove Folder")

	-- Highlight on cursor word
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

return M
