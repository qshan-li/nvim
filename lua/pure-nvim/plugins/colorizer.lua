return {
  "NvChad/nvim-colorizer.lua",
  event = "VeryLazy", -- 改成 VeryLazy → 所有文件立即生效
  opts = {
    filetypes = { "*" }, -- 全局所有文件
    user_default_options = {
      RGB = true, -- #RGB
      RRGGBB = true, -- #RRGGBB ← 最常用
      names = false, -- "blue" 这种名字不显示
      RRGGBBAA = true, -- #RRGGBBAA
      AARRGGBB = true, -- 0xAARRGGBB
      rgb_fn = true, -- rgb(...) 函数
      hsl_fn = true, -- hsl(...)
      css = true, -- 启用 css 颜色
      css_fn = true, -- rgba(...) 函数
      mode = "background", -- background（色块）| foreground（前景色）| virtualtext
      virtualtext = "■■■", -- 可选：在颜色后显示小色块（超可爱）
    },
  },
  config = function(_, opts)
    require("colorizer").setup(opts)
    -- 启动即 attach，所有已打开的 buffer 立即生效
    vim.cmd("ColorizerAttachToBuffer")
  end,
}
