# 01 - Lazy-loading: `lazy = false` 过多

Severity: **High** | Category: Performance

## Problem

多个插件使用 `lazy = false`，在启动时立即加载，增加启动时间。成熟配置（LazyVim、NvChad）的目标是 90%+ 插件延迟加载。

## Affected Plugins

### `lua/pure-nvim/plugins/editor.lua`

| Line | Plugin | Current | Recommended |
|------|--------|---------|-------------|
| 3-6 | `persisted.nvim` | `lazy = false` | `cmd = { "SessionLoad", "SessionSave", "SessionDelete", "SessionStop" }` |
| 12-16 | `faster.nvim` | `lazy = false` | `event = "BufReadPost"` |
| 67-69 | `nvim-treesitter` | `lazy = false` | `event = { "BufReadPost", "BufNewFile" }` (LazyVim uses `LazyFile`) |

### `lua/pure-nvim/plugins/ui.lua`

| Line | Plugin | Current | Recommended |
|------|--------|---------|-------------|
| 3-7 | `minintro.nvim` | `lazy = false` | `lazy = false, priority = 900` (must load before colorscheme) |
| 13-17 | `rose-pine` | `lazy = false` | `lazy = false, priority = 1000` (must load first for colorscheme) |

### `lua/pure-nvim/plugins/tool.lua`

| Line | Plugin | Current | Recommended |
|------|--------|---------|-------------|
| 74-76 | `dropbar.nvim` | `lazy = false` | `event = "BufReadPost"` or `event = "VeryLazy"` |

### `lua/pure-nvim/plugins/completion.lua`

| Line | Plugin | Current | Recommended |
|------|--------|---------|-------------|
| 35-38 | `tiny-inline-diagnostic.nvim` | `lazy = false` | `event = "LspAttach"` or `event = "VeryLazy"` |

## Reference: LazyVim Event Taxonomy

| Event | When | Use For |
|-------|------|---------|
| `VeryLazy` | After UI renders (~100ms) | Non-essential UI plugins |
| `LazyFile` | First file buffer opened | File-dependent plugins |
| `BufReadPost` | Existing file opened | Syntax, highlighting |
| `BufNewFile` | New file created | Templates |
| `InsertEnter` | First insert mode | Completion, snippets |
| `CmdlineEnter` | Command mode entered | Command-line completion |
| `cmd = { ... }` | Specific command invoked | Heavy tools |
| `keys = { ... }` | Specific key pressed | Fuzzy finders |
| `ft = { ... }` | Specific filetype | Language-specific tools |

## Benchmark Reference

| Setup | Typical Startup |
|-------|----------------|
| Vanilla Neovim | 5-10ms |
| Minimal lazy.nvim | 25-40ms |
| Full IDE (optimized) | 60-120ms |
| Unoptimized | 200-500ms+ |

## Verification

```bash
nvim --startuptime /tmp/startup.log +"qa"
head -50 /tmp/startup.log
:Lazy profile  # inside nvim, check per-plugin load time
```

## Action

1. Change `lazy = false` to appropriate `event` / `cmd` / `keys` triggers
2. Keep `lazy = false` only for: colorscheme (with `priority = 1000`), and plugins that MUST load before UI
3. Re-measure startup time after changes
