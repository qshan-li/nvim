-- 备用的主题配置文件，用于回滚到 everforest 主题
return {
  {
    "sainnhe/everforest",
    priority = 1000, -- 在其他插件前加载主题
    config = function()
      -- 设置亮色主题
      vim.g.everforest_background = "soft"
      -- vim.opt.background = "light"
      vim.cmd.colorscheme("everforest")
      -- 设置诊断符号颜色为红色
      vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#e74c3c", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#f39c12", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#3498db", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#9b59b6", bg = "NONE" })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}