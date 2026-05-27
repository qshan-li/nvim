# Neovim Dual-Mode Configuration

A custom Neovim configuration that runs in two distinct modes, sharing core settings between them.

## Architecture

**Dual-Mode Design**: The config detects `vim.g.vscode` at startup and loads the appropriate mode:

- **`lua/shared/`** — Loaded first in both modes. Contains options (leader key, nerd font), keymaps, and shared plugin specs.
- **`lua/pure-nvim/`** — Loaded only in standalone Neovim. Full-featured: lazy.nvim plugin manager, LSP, completion, UI, etc.
- **`lua/vscode-nvim/`** — Loaded only inside VSCode Neovim extension. Minimal: keymaps and a small plugin set.

**Constraint**: VSCode paths are immutable. Shared logic lives in `lua/shared/`, not duplicated.

## Boot Sequence

```
init.lua → require("shared").setup() → detects vim.g.vscode → loads either pure-nvim or vscode-nvim
```

Pure Neovim sets `vim.g.pure_nvim = true` early in its init.

## Plugin Management (Pure Neovim)

Uses **lazy.nvim**. Plugin specs are split by category in `lua/pure-nvim/plugins/`:

- `ui.lua` — UI enhancements
- `lang.lua` — Language support
- `completion.lua` — Completion plugins
- `editor.lua` — Editor features
- `tool.lua` — Development tools

Per-plugin configs live in `lua/pure-nvim/configs/<category>/<plugin>.lua`.

## Settings

Key settings are centralized in `lua/pure-nvim/core/settings.lua`:

- `use_ssh` — Use SSH for plugin updates (default: true)
- `format_on_save` — Enable format on save (default: true)
- `format_timeout` — Format timeout in ms (default: 1000)
- `format_notify` — Show format notifications (default: false)
- `format_modifications_only` — Format only changed lines (default: false)

## Directory Structure

```
lua/
├── shared/           # Shared between both modes
│   ├── init.lua
│   ├── options.lua
│   ├── keymaps.lua
│   └── i18n.lua
├── pure-nvim/        # Standalone Neovim config
│   ├── core/         # Core modules (options, events, pack, keymap)
│   ├── plugins/      # Plugin specs by category
│   └── configs/      # Per-plugin configurations
└── vscode-nvim/      # VSCode Neovim extension config
    └── init.lua
```

## Build / Lint / Test

- **No build step** — config loads directly.
- **Smoke test**: `nvim -u init.lua +"qa"` (full) or `nvim -u lua/pure-nvim/init.lua +"qa"` (pure Neovim only).
- **Format**: `stylua init.lua lua/` — uses tabs, 120 char width, double quotes (see `stylua.toml`).

## Code Style

- **Lua only** — no new Vimscript.
- Idempotent setup pattern: `if M.loaded then return end` at top of `M.setup()`.
- Plugin specs use Lazy format: `{ "author/plugin", opts = ..., keys = ... }`.
- Options use `vim.o` or `vim.opt`; keymaps use `vim.keymap.set` with `{ desc = ... }`.
- Conventional commits preferred (feat:, fix:, refactor:).

## License

MIT