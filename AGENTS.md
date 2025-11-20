# Repository Guidelines

## 核心准则与配置边界

- 最高准则：**禁止改动 VSCode Neovim 配置行为**。VSCode 端以现有行为为准，不接受“顺手重构”“顺手优化”。
- VSCode Neovim 路径：由 `vim.g.vscode` 控制，VSCode 专属逻辑放在 `lua/vscode-nvim/`（`keymaps.lua` + `plugins/`），只允许做最小必要改动。
- 纯 Neovim 路径：仅在非 VSCode 环境下，通过根 `init.lua` 额外加载 `lua/pure-nvim/`，这里可以大幅调整与尝试，但不能破坏 VSCode 端行为。
- 公共配置复用：VSCode 与纯 Neovim 需要共享的逻辑，一律放在 `lua/shared/`（例如 `lua/shared/options.lua`、`lua/shared/keymaps.lua`、`lua/shared/plugins/`），两边各自 `require`，禁止互相硬编码引用。
- Leader 约定：全局 `vim.g.mapleader` 与 `vim.g.maplocalleader` 固定为 `;`，只能在 `lua/shared/options.lua` 中设置，其他地方禁止再改。
- Options 约定：根 `init.lua` 通过 `package.loaded["lazyvim.config.options"] = true` 禁用 LazyVim 自带 options，所有全局选项（包括诊断配色）必须走 `lua/shared/options.lua`。

## 项目结构与模块组织

- 根入口：`init.lua` 为唯一入口，先禁用 `lazyvim.config.options`，再加载 `lua/shared/options.lua` 统一 options/leader，然后通过 `lua/shared/lazy.lua` 初始化 lazy.nvim，并根据 `vim.g.vscode` 决定是否加载纯 Neovim 配置。
- VSCode 配置：`lua/vscode-nvim/keymaps.lua` 提供 VSCode 专属键位映射，`lua/vscode-nvim/plugins/*.lua` 只做 VSCode 端插件的启用/禁用与小范围覆写。
- 纯 Neovim 配置：`lua/pure-nvim/init.lua` 只负责打 `vim.g.pure_nvim` 标记并挂载本地 options/keymaps，实际插件覆写放在 `lua/pure-nvim/plugins/`（例如 `theme.lua`、`nvim-treesitter.lua`、`lsp.lua`、`noice-disable.lua` 等）。
- 公共逻辑：已经抽出的共享逻辑包括 `lua/shared/options.lua`（复制并本地掌控 LazyVim options，同时统一 leader 和诊断颜色）、`lua/shared/keymaps.lua`（基础移动/窗口键位）、`lua/shared/plugins/`（跨环境插件配置，如 colorscheme）。
- 文档与约定：当前主要约定文档是根目录下的 `AGENTS.md` 与 `CLAUDE.md`；如果后续新增 `PURE_NVIM.md`、`THEME_GUIDE.md` 等文档，必须在调整配置时一起更新。

## 构建、运行与开发命令

- 本仓库无“构建”流程，核心就是让 `nvim` 正常启动。
- 本地运行：在任意目录执行 `nvim` 即会加载此配置（假设已作为默认配置目录）；VSCode 端通过 vscode-neovim 插件使用同一目录。
- 最小测试：`nvim -u init.lua +"qa"` 检查入口能否无错误启动并退出（重点保证 VSCode 路径不受影响）。
- 纯净配置测试：`nvim -u lua/pure-nvim/init.lua +"qa"` 只验证 pure-nvim 层 options/keymaps 是否正常加载（不走 Lazy/LazyVim 插件），用于快速 smoke test。
- 代码格式化（可选）：安装 `stylua` 后在仓库根目录运行 `stylua init.lua lua test_config.lua`。

## 代码风格与命名约定

- 语言：全部使用 Lua，禁止混入 Vimscript 新代码。
- 缩进：统一使用 2 空格，不使用 Tab。
- 格式：遵循 `stylua.toml`，提交前尽量跑一次 `stylua`。
- 模块命名：文件名小写、使用中划线或下划线，如 `nvim-tree.lua`、`which-key.lua`。
- 插件定义：单文件返回 Lazy 插件规范表，不要在同一文件里写无关业务逻辑。
- 主题与诊断颜色：与主题相关的全局配置集中在 `lua/shared/options.lua` 和 `lua/pure-nvim/plugins/theme.lua`，诊断虚拟文本（`DiagnosticVirtualText*`）颜色统一在 `lua/shared/options.lua` 中强制设为红色，避免被主题覆盖成灰黑色。

## 测试与验证规范

- 启动自测：提交前至少执行一次 `nvim -u init.lua`，确认无报错、无卡顿。
- 功能验证：针对修改的区域进行对应验证，例如：
  - 改 keymap：进入普通缓冲区实际按键验证。
  - 改 LSP/格式化：打开典型项目文件，验证补全、诊断与格式化。
- `test_config.lua` 可用于快速注入/尝试新配置，避免污染主入口。

## 提交与 Pull Request 规范

- 提交粒度：每次提交聚焦一个清晰改动（例如“新增插件”、“调整 keymap”、“修复启动错误”）。
- 提交信息：推荐英语祈使句或简短中文，示例：`feat: add telescope fzf config`、`fix: 修复 pure-nvim LSP 报错`。
- PR 描述：说明修改目的、涉及文件、手动验证步骤，如有 UI 改动附上截图或简短说明。
- 不写兼容性垃圾：默认面向最新 Neovim/插件版本，不为了旧版本增加复杂分支。
- 不要引入庞大依赖或脚本工具，除非对编辑体验提升明显并在描述中讲清理由。
