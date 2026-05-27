# Contributing

Thank you for your interest in this Neovim configuration!

## Reporting Issues

- Search [existing issues](../../issues) first to avoid duplicates.
- Include your `nvim --version` output.
- Describe the expected behavior vs. actual behavior.
- Provide a minimal reproduction steps if possible.

## Submitting Changes

1. Fork the repository.
2. Create a feature branch: `git checkout -b feat/my-feature`
3. Make your changes.
4. Format with StyLua: `stylua init.lua lua/`
5. Smoke test: `nvim -u init.lua +"qa"`
6. Commit with [Conventional Commits](https://www.conventionalcommits.org/):
   - `feat:` new feature
   - `fix:` bug fix
   - `refactor:` code restructuring
   - `docs:` documentation only
   - `chore:` maintenance tasks
7. Open a Pull Request.

## Code Style

- **Lua only** — no new Vimscript.
- Format with StyLua (see `stylua.toml` for config: tabs, 120 char width, double quotes).
- Idempotent setup: `if M.loaded then return end` at the top of `M.setup()`.
- Options: `vim.o` or `vim.opt`. Keymaps: `vim.keymap.set` with `{ desc = ... }`.
- Plugin specs use Lazy format: `{ "author/plugin", opts = ..., keys = ... }`.
- No `@ts-ignore`, no `any`, no magic values.

## Architecture

See [CLAUDE.md](CLAUDE.md) for the dual-mode architecture, boot sequence, and plugin management details.

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).
