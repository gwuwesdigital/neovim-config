-- Set path to python interpreter
vim.g.python3_host_prog = "$HOME/miniconda3/envs/neovim/bin/python"

-- Use system clipboard in WSL2
vim.g.clipboard = {
	name = "WslClipboard",
	copy = {
		["+"] = "clip.exe",
		["*"] = "clip.exe",
	},
	paste = {
		["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r",""))',
		["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r",""))',
	},
	cache_enabled = 0,
}

-- Prevent C-h C-j C-k C-l moving over the edge
vim.g.tmux_navigator_no_wrap = 1
