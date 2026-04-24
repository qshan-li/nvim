# Theme Style Migration Notes

## Goal

This repository no longer keeps hand-written theme styles in the Neovim config.
Theme appearance should come from the theme plugin itself and from the plugin's official integrations.

The removed customizations are documented here so they can be reintroduced inside `vitesse` later if needed.

## Removed Custom Styles

### `lua/pure-nvim/configs/ui/rose-pine.lua`

- Removed local `rose-pine` style overrides.
- Previous overrides:
  - `variant = "auto"`
  - `dark_variant = "main"`
  - `dim_inactive_windows = false`
  - `extend_background_behind_borders = true`
  - `enable.terminal = true`
  - `enable.legacy_highlights = true`
  - `enable.migrations = true`
  - `styles.bold = true`
  - `styles.italic = false`
  - `styles.transparency = settings.transparent_background`

Current state:
- `rose-pine` now uses `require("rose-pine").setup()` with plugin defaults only.

### `lua/pure-nvim/configs/ui/vitesse.lua`

- Removed local `vitesse` appearance overrides.
- Previous overrides:
  - `transparent = settings.transparent_background`
  - `theme = "light-soft"`
  - all `italics.* = false`

Current state:
- `vitesse` now uses `require("vitesse").setup({})`.

### `lua/pure-nvim/configs/ui/catppuccin.lua`

- Removed local Catppuccin style overrides and highlight patches.
- Previous overrides included:
  - explicit `background`
  - `dim_inactive`
  - `transparent_background`
  - `show_end_of_buffer`
  - `term_colors`
  - `compile_path`
  - custom `styles`
  - custom `color_overrides`
  - large `highlight_overrides` block for float windows, diagnostics, mason, ibl, cmp, fidget, trouble, glance, treehopper, and treesitter

Current state:
- Only plugin integrations are enabled.
- No local palette patching or highlight override is applied from this file anymore.

### `lua/pure-nvim/configs/ui/bufferline.lua`

- Removed local `bufferline` highlight customization for Catppuccin.
- Previous customization:
  - custom `styles = { "bold" }`
  - custom hint color overrides

Current state:
- `vitesse` uses `require("vitesse").bufferline.highlights`
- `catppuccin` uses `require("catppuccin.groups.integrations.bufferline").get()`
- `rose-pine` uses `require("rose-pine.plugins.bufferline")`

All three now come from theme-provided integrations.

### `lua/pure-nvim/configs/ui/lualine.lua`

- Removed local lualine theme table generation and local component color overrides.
- Previous customization:
  - custom Catppuccin theme table
  - component colors for separator, LSP, Python env, cwd, branch, diff

Current state:
- lualine theme is resolved by colorscheme name only:
  - `vitesse` -> `"vitesse"`
  - `catppuccin*` -> `"catppuccin"`
  - `rose-pine*` -> `"rose-pine"`
  - fallback -> `"auto"`
- component-specific hand-written colors are no longer applied

## Kept on Purpose

### `lua/pure-nvim/utils/init.lua`

- The internal palette adapter was kept.
- Reason:
  - other non-theme modules still read from a generic palette interface
  - this layer adapts theme palettes into the config's shared utility API

This is not treated as a theme style override. It is a compatibility layer inside this config.

## Suggested Inputs For Future `vitesse` Styling

If you want to rebuild these aesthetics inside `vitesse`, the most reusable ideas are:

- stronger bold emphasis for statusline accents
- clearer float borders and float backgrounds
- muted inactive UI surfaces
- explicit completion menu borders and selected item contrast
- richer diagnostics and glance/trouble emphasis
- stronger indent and scope contrast

Those should be implemented in `vitesse` itself rather than reintroduced as per-theme patches in this config.
