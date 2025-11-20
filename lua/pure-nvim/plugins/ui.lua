return {
  {
    "nvim-mini/mini.icons",
    lazy = false,
    opts = {
      -- 统一使用 glyph，配合高亮组置灰
      style = "glyph", -- 或 "ascii"
    },
    config = function(_, opts)
      require("mini.icons").setup(opts)

      local grey = "#9ca3af" -- 浅灰，统一覆盖所有内置高亮
      local colors = {
        "Azure",
        "Blue",
        "Cyan",
        "Green",
        "Grey",
        "Orange",
        "Purple",
        "Red",
        "Yellow",
      }
      for _, color in ipairs(colors) do
        vim.api.nvim_set_hl(0, "MiniIcons" .. color, { fg = grey })
      end
    end,
  },
  {
    -- 统一设置 Snacks 和 devicons 图标为灰色的 autocmd
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- 创建统一的图标置灰函数
      local function set_gray_icons()
        local gray = "#808080" -- 你想要的灰色（可以自己换成喜欢的颜色）

        -- 1. Snacks 系列图标高亮（包括 explorer，因为 explorer 本质也是 picker）
        local snacks_hl = vim.fn.getcompletion("Snacks", "highlight")
        for _, hl in ipairs(snacks_hl) do
          -- 只动带 Icon 的 snacks 高亮组，避免误伤其它东西
          if hl:match("Icon") then
            vim.api.nvim_set_hl(0, hl, { fg = gray, nocombine = true })
          end
        end

        -- 2. nvim-web-devicons 的图标（如果你启用的是 devicons）
        local devicons_hl = vim.fn.getcompletion("DevIcon", "highlight")
        for _, hl in ipairs(devicons_hl) do
          vim.api.nvim_set_hl(0, hl, { fg = gray, nocombine = true })
        end

        -- 3. 额外处理 mini.icons 可能产生的高亮组
        local mini_icons_hl = vim.fn.getcompletion("MiniIcons", "highlight")
        for _, hl in ipairs(mini_icons_hl) do
          vim.api.nvim_set_hl(0, hl, { fg = gray, nocombine = true })
        end
      end

      -- 创建 autocmd 组
      local group = vim.api.nvim_create_augroup("PureNvimGrayIcons", { clear = true })

      -- 在 ColorScheme 和 VimEnter 时设置图标颜色
      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        group = group,
        callback = set_gray_icons,
      })

      return opts
    end,
  },
}
