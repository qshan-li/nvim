-- 本地 vitesse 主题配置
local function setup_vitesse_theme()
  -- 添加本地主题路径到 runtimepath
  vim.opt.runtimepath:append("/home/liqingshan/workspace/frontend/nvim-theme-vitesse")

  -- 尝试设置 vitesse light 主题，如果失败则回退到 everforest
  local success, err = pcall(function()
    vim.cmd.colorscheme("vitesse_light")
  end)

  if not success then
    print("Vitesse Light 主题加载失败，回退到 everforest: " .. err)
    vim.g.everforest_background = "soft"
    vim.cmd.colorscheme("everforest")
  end

  -- 强制设置状态栏颜色（vitesse light 主题）
  vim.api.nvim_set_hl(0, "StatusLine", { fg = "#4e4f47", bg = "#f7f7f7" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#393a34", bg = "#f7f7f7" })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#f0f0f0", bg = "NONE" })

  -- 设置诊断符号颜色为红色（light 主题适配）
  vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#d73a49", bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#a65e2b", bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#296aa3", bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#1e754f", bg = "NONE" })
end

-- 原始 everforest 主题配置 (备用)
local function setup_everforest_theme()
  vim.g.everforest_background = "soft"
  vim.cmd.colorscheme("everforest")

  -- 设置诊断符号颜色为红色
  vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#e74c3c", bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#f39c12", bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#3498db", bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#9b59b6", bg = "NONE" })
end

-- 在 LazyVim 完全加载后应用主题设置
vim.defer_fn(function()
  setup_vitesse_theme()
end, 200)

return {
  {
    "sainnhe/everforest",
    priority = 999, -- 降低优先级，作为备用主题
    config = setup_everforest_theme,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vitesse_light", -- 设置为 vitesse light
    },
  },
  -- 自定义主题设置，在插件加载后应用
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- 确保 treesitter 高亮正常工作
      opts.highlight = opts.highlight or {}
      opts.highlight.enable = true
      return opts
    end,
  },
}
