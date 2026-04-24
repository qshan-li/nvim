local M = {}

function M.setup()
	-- 加载 VS Code 专用插件
	require("vscode-nvim.plugins").setup()
	-- 加载 VS Code 专用快捷键
	require("vscode-nvim.keymaps").setup()
end

return M
