-- 禁用 LazyVim 默认 options 模块，确保由我们统一控制 mapleader 等选项
package.loaded["lazyvim.config.options"] = true

-- 先加载共享 options，保证 VSCode 与纯 Neovim 使用同一套基础配置
require("shared.options").setup()

-- 共享基础键位（包含 VSCode 专属映射）
require("shared.keymaps")

-- 然后加载 Lazy 和插件
require("shared.lazy")

-- 检测环境并加载相应配置
if not vim.g.vscode then
  -- 加载纯 Neovim 配置
  require("pure-nvim")
end



