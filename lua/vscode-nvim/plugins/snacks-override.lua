-- VSCode 环境下禁用 Snacks 自带的按键，避免抢占 VSCode 的快捷键（例如 <leader>e）
return {
  {
    "folke/snacks.nvim",
    keys = function()
      return {}
    end,
  },
}
