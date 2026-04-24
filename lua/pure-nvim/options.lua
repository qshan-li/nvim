require("shared.options").setup()

-- Pure Neovim 专用系统寄存器配置
-- 确保与系统剪贴板完全同步
if not vim.g.vscode then
	-- 在纯 Neovim 环境下强制启用 unnamedplus，确保与系统剪贴板共享
	vim.opt.clipboard = "unnamedplus"

	-- 可选：如果需要同时使用 unnamed 和 unnamedplus（兼容性更好）
	-- vim.opt.clipboard = "unnamed,unnamedplus"
end
