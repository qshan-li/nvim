# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/), and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added
- CONTRIBUTING.md with contribution guidelines.
- CHANGELOG.md (this file).
- GitHub Actions CI: smoke test and StyLua format check.
- Issue and PR templates.

### Changed
- LICENSE unified to MIT (was Apache 2.0 in file, MIT in README).
- Removed `github-repo-investigator` artifacts from git tracking.

## [0.1.0] - 2024-02-03

### Added
- Initial commit: dual-mode Neovim configuration (standalone + VSCode).
- Pure Neovim: lazy.nvim plugin management, LSP, completion, UI, DAP, terminal.
- VSCode Neovim: minimal keymaps and plugin set.
- Shared layer: options, keymaps, i18n support.
