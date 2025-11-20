-- 纯 Neovim 配置入口文件
-- 仅在非 VSCode 环境下加载

-- 设置纯 Neovim 模式标记
vim.g.pure_nvim = true

-- 基础选项与键位（shared.keymaps 已在初始化时自动加载）
require("pure-nvim.options")
require("pure-nvim.keymaps")

-- 加载主题切换器（仅在 pure-nvim 环境下）
local theme_switcher = require("shared.theme-switcher")
-- 设置全局快捷键用于主题切换
vim.keymap.set("n", "<leader>tt", "<cmd>ThemeSwitch<cr>", { desc = "切换主题" })
vim.keymap.set("n", "<leader>tv", theme_switcher.vitesse_light, { desc = "Vitesse Light 主题" })
vim.keymap.set("n", "<leader>te", theme_switcher.everforest, { desc = "Everforest 主题" })
vim.keymap.set("n", "<leader>td", theme_switcher.vitesse, { desc = "Vitesse 暗色主题" })
