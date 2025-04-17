local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		-- diagnostics.mypy,
		diagnostics.hadolint,
		diagnostics.sqlfluff.with({
			command = "/home/george/miniconda3/envs/sdw/bin/sqlfluff",
			to_temp_file = false,
		}),
		formatting.shfmt,
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.prettierd,
		formatting.stylua,
		formatting.sqlfluff.with({
			command = "/home/george/miniconda3/envs/sdw/bin/sqlfluff",
		}),
	},
})
