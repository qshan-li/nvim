return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- 1. 显式绑定 <space> 键来触发 WhichKey 面板
    keys = {
      -- {
      --   "<space>",
      --   function()
      --     require("which-key").show()
      --   end,
      --   desc = "Show Keymaps",
      -- },
    },
    opts = function(_, opts)
      opts = opts or {}

      -- 2. 核心逻辑：增加自动触发的延迟（2秒）
      -- 这样当你按下 Leader (;) 时，除非你停顿 2 秒，否则面板不会自动跳出来
      -- 配合上面的 keys 设置，实现了 "Leader 仅用于指令，Space 仅用于查看菜单"
      -- opts.delay = function(ctx)
      --   return ctx.plugin and 0 or 2000
      -- end

      opts.spec = opts.spec or {}

      -- 移除默认的 w 键 windows 组，并重新定义
      table.insert(opts.spec, {
        -- 禁用默认的 w -> +windows
        { "<leader>w", hidden = true },
        -- 新的 w 键映射：保存文件 (现在是 ;w)
        { "<leader>w", "<cmd>w<cr>", desc = "Save File" },
        -- 新的 W 键映射：windows 功能组 (现在是 ;W)
        {
          "<leader>W",
          group = "windows",
          expand = function()
            return require("which-key.extras").expand.win()
          end,
        },
      })

      -- 窗口配置：顶部 + 高度最多两行，尽量紧凑
      opts.win = vim.tbl_deep_extend("force", opts.win or {}, {
        no_overlap = false, -- 固定位置
        border = "rounded",
        padding = { 0, 1 },
        title = false,
        row = 2,   -- 顶部
        col = 0.5, -- 水平居中
        height = { min = 12, max = 24 },
        width = { min = 80, max = 80 },
        zindex = 1000,
        bo = {},
        wo = {
          winblend = 10,
        },
      })

      -- 布局上只收紧一下列间距
      opts.layout = vim.tbl_deep_extend("force", opts.layout or {}, {
        spacing = 2,
      })

      return opts
    end,
  },
}
