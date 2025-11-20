-- Snacks.nvim 配置 - explorer 在右侧，禁用 terminal
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = {
      sources = {
        explorer = {
          tree = {
            indent = false, -- 禁用缩进线条，但保持层级结构
          },
          hidden = true,
          ignored = true,
          layout = {
            layout = {
              position = "right",
              width = 40,
              border = "none",
            },
            auto_hide = { "input" },
          },
          -- vscode-icons-carbon 风格配置
          icons = {
            files = {
              enabled = true,
              -- Carbon Design System 风格的文件图标 (基于 antfu/vscode-icons-carbon)
              dir = "󰉋 ",        -- 文件夹 (Folder)
              dir_open = "󰝰 ",   -- 打开的文件夹 (Folder Open)
              file = "󰈔 ",       -- 默认文件 (File)
              -- 常见文件类型
              ["js"] = "󰌞 ",     -- JavaScript
              ["ts"] = "󰛦 ",     -- TypeScript
              ["jsx"] = "󰜈 ",    -- React JSX
              ["tsx"] = "󰜈 ",    -- React TSX
              ["vue"] = "󰡄 ",    -- Vue
              ["html"] = "󰌝 ",   -- HTML
              ["css"] = "󰌗 ",    -- CSS
              ["scss"] = "󰁀 ",   -- Sass/SCSS
              ["json"] = "󰘦 ",   -- JSON
              ["md"] = "󰍔 ",     -- Markdown
              ["yml"] = "󰌪 ",    -- YAML
              ["yaml"] = "󰌪 ",   -- YAML
              ["toml"] = "󰌪 ",   -- TOML
              ["lock"] = "󰌾 ",   -- Lock File
              ["git"] = "󰊢 ",    -- Git
              ["svg"] = "󰜡 ",    -- SVG
              ["png"] = "󰍸 ",    -- PNG
              ["jpg"] = "󰍸 ",    -- JPG
              ["jpeg"] = "󰍸 ",   -- JPEG
              ["gif"] = "󰵸 ",    -- GIF
              ["ico"] = "󰍪 ",    -- ICO
              ["pdf"] = "󰈦 ",    -- PDF
              ["zip"] = "󰗄 ",    -- ZIP
              ["tar"] = "󰏔 ",    -- TAR
              ["gz"] = "󰏔 ",     -- GZIP
              ["dockerfile"] = "󰡨 ", -- Dockerfile
              ["docker"] = "󰡨 ",  -- Docker
              ["node_modules"] = "󰎙 ", -- Node Modules
            },
            tree = {
              vertical = "  ",    -- 垂直线改为空格，保持极简
              middle = "  ",      -- 中间节点改为空格
              last = "  ",        -- 最后节点改为空格
            },
            -- UI 状态图标 (Carbon Design System 风格)
            ui = {
              selected    = "● ",   -- 选中状态 (Filled Circle)
              unselected  = "○ ",   -- 未选中状态 (Outline Circle)
              hidden      = "👁 ",  -- 隐藏文件 (Eye)
              ignored     = "⊘ ",   -- 忽略文件 (Circle with Slash)
              follow      = "→ ",   -- 跟随文件 (Arrow Right)
              live        = "◉ ",   -- 实时搜索 (Target)
            },
          },
        },
      },
    },
    -- terminal = {
    --   enabled = false,
    -- },
  },
  keys = {
    -- { "<leader>fT", false, mode = "n" }, -- 禁用 终端（当前工作目录）
    -- { "<leader>ft", false, mode = "n" }, -- 禁用 终端（根目录）
    -- { [[<C-/>]], false, mode = { "n", "t" } }, -- 禁用 终端（根目录）
    -- { [[<C-_>]], false, mode = { "n", "t" } }, -- 禁用 which_key_ignore（终端相关）
  },
}
