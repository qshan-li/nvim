-- Bufferline 配置
return {
  "akinsho/bufferline.nvim",
  enabled = false,
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<S-h>", false },  -- 禁用 Shift+H (左移 buffer)
    { "<S-l>", false },  -- 禁用 Shift+L (右移 buffer)
  },
  config = function()
    require("bufferline").setup({
      options = {
        -- 使用 nvim-tree 的图标
        mode = "buffers",
        -- 显示文件名而不是路径
        show_buffer_close_icons = true,
        show_buffer_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        -- 关闭时的行为
        always_show_bufferline = true,
        -- 样式配置
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        -- 高亮当前 buffer
        numbers = "none",
        -- 显示始终可见的 buffer
        show_buffer_default_icon = true,
        -- 缓冲区排序
        sort_by = "insert_after_current",
        -- 自定义 buffer 名称显示
        name_formatter = function(buf)
          local name = buf.name:match(".*%.([^.]+)$") or buf.name:match("^.+/(.+)$") or buf.name
          if name == "" then
            return "[No Name]"
          end
          return name
        end,
        -- 自定义区域分组（基于目录）
        groups = {
          items = {
            require("bufferline.groups").by_directory,
          },
        },
      },
    })
  end,
}
