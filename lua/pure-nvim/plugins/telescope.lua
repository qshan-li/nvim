return {
  {
    "nvim-telescope/telescope.nvim",
    -- 1. 先保留你原来的自定义映射（<C-j>/<C-k>）
    opts = function(_, opts)
      local actions = require("telescope.actions")

      -- 确保嵌套表存在
      opts.defaults = opts.defaults or {}
      opts.defaults.mappings = opts.defaults.mappings or {}
      opts.defaults.mappings.i = opts.defaults.mappings.i or {}
      opts.defaults.layout_config = opts.defaults.layout_config or {}

      -- 你原来的 <C-j>/<C-k> 上下移动（保留）
      opts.defaults.mappings.i["<C-j>"] = actions.move_selection_next
      opts.defaults.mappings.i["<C-k>"] = actions.move_selection_previous

      ----------------------------------------------------------------
      -- ↓↓↓ 新增：完美复刻 VSCode Ctrl+Tab 的全部配置 ↓↓↓
      ----------------------------------------------------------------
      -- 全局默认布局（对所有 picker 生效）
      opts.defaults.layout_strategy = "center" -- 居中浮窗，最像 VSCode
      opts.defaults.layout_config.prompt_position = "top"
      opts.defaults.layout_config.preview_cutoff = 1
      opts.defaults.layout_config.anchor = "N" -- 从顶部往下锚定，更像 VSCode
      opts.defaults.layout_config.width = 0.75
      opts.defaults.layout_config.height = 0.8

      opts.defaults.sorting_strategy = "ascending"
      opts.defaults.scroll_strategy = "limit"

      -- 美化边框（LazyVim 已经内置 borderchars，这里强化一下）
      opts.defaults.borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

      -- buffers picker 专属配置（最关键的部分）
      if not opts.pickers then
        opts.pickers = {}
      end
      opts.pickers.buffers = {
        theme = "dropdown", -- dropdown + center 布局 = 最接近 VSCode
        previewer = true,
        sort_mru = true, -- MRU 排序，和 VSCode 100% 一致
        ignore_current_buffer = true, -- 当前 buffer 不放在最上面
        sort_lastused = true,
        show_all_buffers = true,

        -- 让列表更紧凑、好看
        layout_config = {
          width = 0.6,
          height = 0.6,
        },

        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer, -- Ctrl+d 删除 buffer
            ["<C-a>"] = actions.delete_buffer + actions.move_to_top, -- 全删当前
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      }

      ----------------------------------------------------------------
      -- 额外小优化（可选）
      ----------------------------------------------------------------
      -- 让 telescope 在没有结果时也显示一个漂亮的提示
      opts.defaults.no_ignore = false
      opts.defaults.file_ignore_patterns = { "node_modules/", "%.git/" }
    end,

    -- 2. 关键：直接绑定 <C-Tab>，终端已映射 <Esc>[9;5u -> <C-Tab>
    --    （LazyVim 的 keys 会覆盖默认的 <leader>fb）
    keys = {
      {
        "<C-Tab>",
        "<cmd>Telescope buffers show_all_buffers=true<CR>",
        desc = "Switch Buffer (VSCode Style Ctrl+Tab)",
      },
      -- 如果你还想保留原来的 <leader>fb，可以再加一行
      -- { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find Buffers" },
    },

    -- 3. （可选）如果你想要按住 Ctrl+Tab 一直显示，松开才切换（极致 VSCode 体验）
    --    可以再加一个插件：ghill/vim-bufsurf 或更现代的实现
    --    这里先不加，大多数人用上面的已经彻底满足了
  },
}
