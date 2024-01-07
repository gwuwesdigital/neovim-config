local M = {}

local has_value = function(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

M.save_and_quit = function(mode)
	local accepted_modes = { "single", "all" }
	assert(has_value(accepted_modes, mode), "Unknown mode " .. mode .. " change to 'single' or 'all'")

	local session_file = vim.fn.findfile("Session.vim")
	if session_file ~= "" then
		if mode == "single" then
			vim.cmd([[mksession! | q]])
		else
			vim.cmd([[mksession! | qa]])
		end
	else
		if mode == "single" then
			vim.cmd([[q]])
		else
			vim.cmd([[qa]])
		end
	end
end

return M
