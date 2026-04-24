# Repository Guidelines

## Build/Lint/Test Commands

- **No build process** - this is a Neovim configuration that loads directly
- **Startup tests**:
  - Full config: `nvim -u init.lua +"qa"` - verifies VSCode and pure Neovim paths
  - Pure Neovim only: `nvim -u lua/pure-nvim/init.lua +"qa"` - quick smoke test
- **Linting/Formatting**: `stylua init.lua lua/` (requires stylua)
- **Manual verification** required before commits:
  - Open `nvim` and confirm no errors/crashes
  - Test modified functionality (keymaps, LSP, formatting, etc.)

## Code Style Guidelines

### Language & Formatting

- **Lua only** - no new Vimscript code
- Follow `stylua.toml` config: Tab indentation, 120 char line width, double-quoted strings preferred
- Submit with `stylua init.lua lua/` before pushing

### File Structure

- **`init.lua`** - sole entry point, loads shared then detects environment (vim.g.vscode)
- **`lua/shared/`** - shared logic (options.lua, keymaps.lua, plugins/, i18n.lua)
- **`lua/pure-nvim/`** - pure Neovim only (init.lua sets vim.g.pure_nvim, plugins/ for overrides)
- **`lua/vscode-nvim/`** - VSCode Neovim only (keymaps.lua, plugins.lua for minimal edits)

### Module Patterns

**Setup modules** (shared entry points):

```lua
local M = {}
function M.setup()
  if M.loaded then return end
  M.loaded = true
  -- setup code
end
return M
```

**Plugin definitions** (return Lazy spec table):

```lua
return {
  {
    "author/plugin",
    opts = function(_, opts)
      -- merge/extend opts
      return opts
    end,
    keys = { { "lhs", rhs, mode = "n", desc = "Description" } }
  }
}
```

### Options & Keymaps

**Options** (in `lua/shared/options.lua`):

```lua
vim.o.option = value  -- or vim.opt.option = value
-- Diagnostic virtual text colors forced to red in options.lua
```

**Keymaps**:

```lua
vim.keymap.set({ "n", "v" }, "lhs", "rhs", { desc = "Description", remap = true })
vim.api.nvim_set_keymap("n", "\x1b[13;5u", "rhs", { noremap = true, silent = true })
```

### Naming Conventions

- File names: lowercase with hyphens or underscores (`telescope.lua`, `nvim-treesitter.lua`)
- Module functions: PascalCase (`M.setup`, `M.configure`)
- Plugin spec keys: `event`, `opts`, `keys`, `config`, `init`

### Error Handling

- Use `if M.loaded then return end` pattern for idempotent setup
- No explicit try/catch patterns in this codebase

## Critical Constraints

- **VSCode behavior is immutable** - no "refactor" or "optimization" to VSCode paths
- Shared logic goes in `lua/shared/`, referenced by both sides via `require()`
- Leader keys fixed to space in `lua/shared/options.lua` only
- Diagnostic virtual text colors unified in `lua/shared/options.lua` (red override)
- No compatibility shims - target latest Neovim/versions

## Submission Guidelines

- Single focused commit per change (e.g., "feat: add telescope fzf config")
- Conventional commits preferred (feat:, fix:, refactor:)
- Verify startup: `nvim -u init.lua +"qa"` before pushing
- Test actual functionality (keymaps, LSP, formatting) on real files
- No heavy dependencies unless explicitly justified
