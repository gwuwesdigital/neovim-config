local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
	return
end
illuminate.configure({
	filetypes_denylist = {
		"dirbuf",
		"dirvish",
		"fugitive",
        "NvimTree"
	},
	large_file_cutoff = 1000,
})
