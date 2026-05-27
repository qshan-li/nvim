# General Codebase Analysis Patterns

Use these patterns to map out and understand standard software repositories (Web, Backend, CLI, etc.).

## 1. Entry Point Identification
- **Web**: `index.html`, `src/main.ts`, `App.tsx`.
- **Node.js**: `package.json` (`main` or `bin` fields), `src/index.ts`, `server.ts`.
- **Go**: `main.go`, `cmd/` directory.
- **Python**: `__main__.py`, `app.py`, `wsgi.py`.
- **Rust**: `src/main.rs`, `src/lib.rs`.

## 2. Tech Stack & Dependencies
- Identify core libraries from manifest files (`package.json`, `go.mod`, `Cargo.toml`, `requirements.txt`).
- Note key frameworks (React, Gin, FastAPI, Spring Boot).

## 3. Directory Structure Heuristics
- `src/` or `lib/`: Main logic.
- `api/` or `controllers/`: External interface.
- `models/` or `types/`: Data structures.
- `utils/` or `shared/`: Helper functions.
- `tests/` or `spec/`: Testing suite.
- `docs/`: Manuals and diagrams.

## 4. Architectural Patterns
- **Layered**: Controller -> Service -> Repository.
- **Microservices**: Multiple sub-folders with their own manifest files.
- **Monorepo**: Workspace configuration (e.g., `pnpm-workspace.yaml`, `nx.json`).
- **Event-Driven**: Message queues, pub/sub logic.

## 5. Environment & Config
- Check `.env.example`, `config/`, or `settings/` to see how the app is configured.
