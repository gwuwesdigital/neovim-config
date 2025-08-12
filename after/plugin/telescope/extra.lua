local M = {}

-- define custom function to search in a git repo
-- if .git/ exists or otherwise trigger built-in find_files
M.project_files = function()
	local opts = {}
	vim.fn.system("git rev-parse --is-inside-work-tree")
	if vim.v.shell_error == 0 then
		require("telescope.builtin").git_files(opts)
	else
		require("telescope.builtin").find_files(opts)
	end
end

return M
