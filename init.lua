-- 先加载共享配置，保证 VSCode 与纯 Neovim 使用同一套基础配置
require("shared").setup()

-- 检测环境并加载相应配置
if not vim.g.vscode then
	-- 加载纯 Neovim 配置
	require("pure-nvim")
else
	-- 加载 VSCode Neovim 配置
	require("vscode-nvim").setup()
end
