-- Set path to python interpreter
vim.g.python3_host_prog = "$HOME/miniconda3/envs/neovim/bin/python"

-- Use system clipboard in WSL2
vim.g.clipboard = {
	name = "WslClipboard",
	copy = {
		["+"] = "/mnt/c/windows/system32/clip.exe",
		["*"] = "/mnt/c/windows/system32/clip.exe",
	},
	paste = {
		["+"] = '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r",""))',
		["*"] = '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r",""))',
	},
	cache_enabled = 0,
}
