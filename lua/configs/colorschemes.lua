local scheme = "tokyonight-storm"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. scheme)
if not status_ok then
	return
end
