---
name: github-repo-investigator
description: Deeply analyze, learn, and investigate GitHub repositories or local codebases. Use when the user provides a GitHub URL or local repo path to understand technical architecture, code logic, or AI prompt strategies.
---

# GitHub Repo Investigator

This skill guides you through a systematic process to understand any GitHub repository, whether it's a traditional software project or a modern AI "skill" / agent repository.

## Workflow

### 1. Preparation & Cloning
- If the user provides a GitHub URL, **clone the repository locally** into a temporary directory (e.g., using `run_shell_command` with `git clone --depth 1 <URL> /tmp/repo-investigator-xxx`). This is much faster and more accurate than using `web_fetch`.
- If the user provides a local path, navigate to it or use it as the `dir_path` for subsequent tools.

### 2. Initial Reconnaissance
Gather high-level metadata using local file tools:
- Read `README.md` to understand the stated purpose.
- Use `list_directory` or `glob` (e.g., `*`, `src/*`) to get a sense of the top-level structure.
- Identify the repo type:
    - **AI Skill Repo**: Look for `.txt` prompts, `SKILL.md`, `AGENTS.md`, or logic involving LLM providers. See [references/ai-skill-analysis.md](references/ai-skill-analysis.md).
    - **Standard Code Repo**: Look for manifest files like `package.json`, `go.mod`, `Cargo.toml`, etc. See [references/code-patterns.md](references/code-patterns.md).

### 3. Strategic Mapping
Determine the "Heart" of the repository:
- Use `grep_search` to find core initializations, main entry points, or prompt definitions.
- **Code**: Identify the entry point (e.g., `main.go`, `index.ts`) and the core business logic folder.
- **AI Skill**: Identify the primary system prompts and tool definitions.
- Trace the most important data flow (e.g., "How does a request get processed?" or "How does the agent decide which tool to call?").

### 4. Deep Dive Analysis
Pick 2-3 critical files or modules for a surgical read:
- Use `read_file` with `start_line` and `end_line` to avoid context overflow.
- Explain complex logic, design patterns, or prompt engineering techniques found.

### 5. Comprehensive Reporting
Present your findings in a structured Markdown format:
- **Project Essence**: 1-sentence summary.
- **Technical Stack**: Languages, frameworks, and key AI models used.
- **Architecture/Flow**: A high-level description of how components interact.
- **Key Files**: List the most important files and their roles.
- **Learning Highlights**: What makes this repo unique (e.g., a clever prompt technique or a robust error-handling pattern).
- **Setup/Usage**: Brief summary of how to run or use it.

## Guidelines
- **Language**: All analysis, communication, and the final report MUST be in **Chinese**.
- **Be Empirical**: Don't guess. If you're unsure about a dependency, read the manifest file directly.
- **Efficiency**: Clone repos locally instead of doing multiple `web_fetch` calls. Use `grep_search` and `glob` heavily.
- **Context Management**: For large repos, focus on the `src/` or equivalent directory. Ignore `dist/`, `build/`, and `node_modules/`.
- **AI Specifics**: When analyzing AI repos, pay close attention to how "context window" and "token usage" are managed in the code/prompts.
