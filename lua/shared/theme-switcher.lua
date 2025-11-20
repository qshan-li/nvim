-- 主题切换工具函数
local M = {}

-- 本地 vitesse 主题路径
local vitesse_path = "/home/liqingshan/workspace/frontend/nvim-theme-vitesse"

-- 可用的主题配置
M.themes = {
  vitesse = {
    name = "vitesse",
    display_name = "Vitesse (本地主题)",
    setup = function()
      vim.opt.runtimepath:append(vitesse_path)
      vim.cmd.colorscheme("vitesse")
      -- 强制设置状态栏颜色
      vim.api.nvim_set_hl(0, "StatusLine", { fg = "#bfbaaa", bg = "#181818" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#858480", bg = "#181818" })
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#191919", bg = "NONE" })
      print("切换到 Vitesse 主题")
    end,
  },
  vitesse_light = {
    name = "vitesse_light",
    display_name = "Vitesse Light (本地主题)",
    setup = function()
      vim.opt.runtimepath:append(vitesse_path)
      vim.cmd.colorscheme("vitesse_light")
      -- 强制设置状态栏颜色
      vim.api.nvim_set_hl(0, "StatusLine", { fg = "#4e4f47", bg = "#f7f7f7" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#393a34", bg = "#f7f7f7" })
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#f0f0f0", bg = "NONE" })
      print("切换到 Vitesse Light 主题")
    end,
  },
  vitesse_light_soft = {
    name = "vitesse_light_soft",
    display_name = "Vitesse Light Soft (本地主题)",
    setup = function()
      vim.opt.runtimepath:append(vitesse_path)
      vim.cmd.colorscheme("vitesse_light_soft")
      print("切换到 Vitesse Light Soft 主题")
    end,
  },
  vitesse_soft = {
    name = "vitesse_soft",
    display_name = "Vitesse Soft (本地主题)",
    setup = function()
      vim.opt.runtimepath:append(vitesse_path)
      vim.cmd.colorscheme("vitesse_soft")
      print("切换到 Vitesse Soft 主题")
    end,
  },
  vitesse_black = {
    name = "vitesse_black",
    display_name = "Vitesse Black (本地主题)",
    setup = function()
      vim.opt.runtimepath:append(vitesse_path)
      vim.cmd.colorscheme("vitesse_black")
      print("切换到 Vitesse Black 主题")
    end,
  },
  everforest = {
    name = "everforest",
    display_name = "Everforest (备用主题)",
    setup = function()
      vim.g.everforest_background = "soft"
      vim.cmd.colorscheme("everforest")
      print("切换到 Everforest 主题")
    end,
  },
}

-- 切换到指定主题
function M.switch_theme(theme_name)
  local theme = M.themes[theme_name]
  if not theme then
    print("未知主题: " .. theme_name)
    return false
  end

  local success, err = pcall(theme.setup)
  if success then
    -- 重新设置诊断颜色
    if theme_name == "vitesse_light" or theme_name == "vitesse_light_soft" then
      -- Light theme colors
      vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#d73a49", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#a65e2b", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#296aa3", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#1e754f", bg = "NONE" })
    else
      -- Dark theme colors
      vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#e74c3c", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#f39c12", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#3498db", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#9b59b6", bg = "NONE" })
    end
    return true
  else
    print("主题切换失败: " .. err)
    return false
  end
end

-- 列出所有可用主题
function M.list_themes()
  local theme_list = {}
  for name, theme in pairs(M.themes) do
    table.insert(theme_list, string.format("%-20s - %s", name, theme.display_name))
  end
  print("可用主题:")
  for _, line in ipairs(theme_list) do
    print("  " .. line)
  end
end

-- 创建命令供用户使用
vim.api.nvim_create_user_command("ThemeSwitch", function(opts)
  if opts.args == "" then
    M.list_themes()
  else
    M.switch_theme(opts.args)
  end
end, {
  nargs = "?",
  complete = function()
    return vim.tbl_keys(M.themes)
  end,
})

-- 快速切换函数
function M.vitesse() M.switch_theme("vitesse") end
function M.vitesse_light() M.switch_theme("vitesse_light") end
function M.vitesse_light_soft() M.switch_theme("vitesse_light_soft") end
function M.vitesse_soft() M.switch_theme("vitesse_soft") end
function M.vitesse_black() M.switch_theme("vitesse_black") end
function M.everforest() M.switch_theme("everforest") end

return M