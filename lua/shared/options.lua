local M = {}

function M.setup()
	if M.loaded then
		return
	end
	M.loaded = true

	-- Leader 必须在加载插件之前设置
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	-- Nerd Font
	vim.g.have_nerd_font = true
end

return M
