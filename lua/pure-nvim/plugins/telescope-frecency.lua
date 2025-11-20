return {
  "nvim-telescope/telescope-frecency.nvim",
  version = "*", -- 使用最新稳定版本
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- 数据库配置
    db_safe_mode = false, -- 禁用数据库清理确认对话框
    auto_validate = true, -- 自动清理无效条目
    db_validate_threshold = 10, -- 清理阈值

    -- 性能优化
    db_version = "v2", -- 使用新版数据库算法
    bootstrap = true, -- 异步初始化数据库

    -- 匹配器配置
    matcher = "fuzzy", -- 使用模糊匹配
    scoring_function = function(recency, fzy_score)
      local score = (10 / (recency == 0 and 1 or recency)) - 1 / fzy_score
      return score == -1 and -1.000001 or score
    end,

    -- 显示配置
    show_scores = false, -- 不显示分数
    show_filter_column = true, -- 显示过滤列
    hide_current_buffer = false, -- 显示当前缓冲区
    path_display = { "filename_first" }, -- 文件名优先显示

    -- 工作区过滤配置
    show_unindexed = true, -- 显示未索引文件
    default_workspace = "CWD", -- 默认工作区
    workspaces = {
      -- 可以在这里添加自定义工作区
      -- CONF = { "~/.config" },
      -- PROJECTS = { "~/projects", "~/work" },
    },

    -- 忽略模式
    ignore_patterns = {
      "*.git/*",
      "*/tmp/*",
      "term://*",
      "*/node_modules/*",
      "*/.venv/*",
      "*/target/*",
    },

    -- 其他配置
    max_timestamps = 10, -- 最大时间戳数量
    disable_devicons = false, -- 启用文件图标
    enable_prompt_mappings = false, -- 禁用提示映射
    unregister_hidden = false, -- 隐藏缓冲区不重新注册
  },
  config = function()
    require("telescope").load_extension("frecency")

    -- 键位映射
    vim.keymap.set("n", "<leader>ff", function()
      require("telescope").extensions.frecency.frecency({
        workspace = "CWD",
        path_display = { "filename_first" },
      })
    end, { desc = "Frecency (当前目录)" })
  end,
}
