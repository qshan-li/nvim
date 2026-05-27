# 02 - Dead Code: 未使用的配置文件

Severity: **High** | Category: Code Hygiene

## Problem

存在多个配置文件、代码片段、元数据文件没有被任何插件规范引用，属于残留代码。

## Inventory

### Unused Config Files

| File | Status | Evidence |
|------|--------|----------|
| `lua/pure-nvim/configs/ui/neoscroll.lua` | No plugin spec references it | `plugins/ui.lua` has no `neoscroll` entry |
| `lua/pure-nvim/configs/ui/catppuccin.lua` | No plugin spec references it | `plugins/ui.lua` only loads `rose-pine` |
| `lua/pure-nvim/configs/ui/vitesse.lua` | No plugin spec references it | Same as above |

### Vestigial Metadata

| File | Issue |
|------|-------|
| `lazyvim.json` | References LazyVim extras (claudecode, mini-surround, tailwind, etc.) but this config does NOT use LazyVim as a base. Leftover from a previous setup. |

### Unused Snippet Files

| File | Issue |
|------|-------|
| `snips/snippets/c.json` | VSCode-format JSON snippets, but no snippet engine (LuaSnip, vsnip, vim-vsnip) is configured in completion setup |
| `snips/snippets/cpp.json` | Same |
| `snips/snippets/go.json` | Same |

### Unused CMP Source

| Location | Issue |
|----------|-------|
| CMP `sources` list in `configs/completion/cmp.lua` | `orgmode` source is listed, but no orgmode plugin is configured. Harmless (cmp ignores missing sources) but dead config. |

## Action

1. Delete `lazyvim.json`
2. Delete or move unused configs (`neoscroll.lua`, `catppuccin.lua`, `vitesse.lua`) to a `configs/_archived/` directory if you plan to use them later
3. Either configure a snippet engine to use `snips/snippets/`, or delete the snippet files
4. Remove `orgmode` from CMP sources
